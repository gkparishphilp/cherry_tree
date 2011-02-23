# == Schema Information
# Schema version: 20110210211558
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  type                      :string(255)
#  site_id                   :integer(4)
#  registered_by_id          :integer(4)
#  email                     :string(255)
#  name                      :string(255)
#  display_name              :string(255)
#  score                     :integer(4)      default(0)
#  birthday                  :datetime
#  gender                    :string(255)
#  points_earned             :integer(4)      default(0)
#  points_balance            :integer(4)      default(0)
#  level                     :integer(4)      default(0)
#  website_name              :string(255)
#  website_url               :string(255)
#  bio                       :text
#  hashed_password           :string(255)
#  salt                      :string(255)
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  activation_code           :string(255)
#  activated_at              :datetime
#  invitation_code           :string(255)
#  status                    :string(255)     default("first")
#  cached_slug               :string(255)
#  orig_ip                   :string(255)
#  last_ip                   :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#


require 'digest/sha1'

class User < ActiveRecord::Base
	# Constants    --------------------------------------
	ANONYMOUS_ID = 1

	# Filters		--------------------------------------
	before_save	 	:strip_website_url, :set_name
	after_create	:set_avatar
  
	# Validations	--------------------------------------
	validates	:email, :uniqueness => true, 
						:length => {:minimum => 3, :maximum => 254},
						:email => true,
						:unless => :is_child?
						
	validates	:password, :confirmation => true, :length => { :minimum => 4, :maximum => 254 }, :if => :has_password?

	validates	:name, :uniqueness => true, 
						:length => {:minimum => 2, :maximum => 254},
						:format => /\A[a-zA-Z0-9_]+\z/,
						:if => :has_name?

	# Relations   	--------------------------------------
	has_many	:openids
	has_many	:roles
	has_many	:admin_sites, :through => :roles, :source => :site, :conditions => "role = 'admin'"
	has_many	:contributor_sites, :through => :roles, :source => :site, :conditions => "role = 'contributor'"
	has_many	:posts
	has_many	:comments
	has_many	:contacts
	has_many	:twitter_accounts, 	:as => :owner
	has_many	:facebook_accounts,	:as => :owner
	
	has_many	:articles, :as => :owner


	# Testing robust relationships
	has_many	:relationships
	has_many	:related_users, :through => :relationships
	has_many	:relatives, :through => :relationships, 
							:source => :related_user, 
							:conditions => "role IN ( 'son', 'daughter', 'mother', 'father', 'guardian', 'brother',
							'sister', 'aunt', 'uncle', 'niece', 'nephew','cousin', 'grandmother', 'grandfather',
							'grandson', 'granddaughter', 'relative', 'stepmother', 'stepfather' )"
	has_many	:children, :through => :relationships, 
							:foreign_key => :related_user_id, 
							:class_name => 'Child', 
							:source => :related_user, 
							:conditions => "role IN ( 'mother', 'father', 'guardian' )"
	has_many	:supported_children, :through => :relationships, 
									:foreign_key => :related_user_id, 
									:class_name => 'Child', 
									:source => :related_user, 
									:conditions => "role NOT IN ( 'mother', 'father', 'guardian' )"
	has_many	:parents, :through => :relationships, 
						:source => :related_user, 
						:conditions => "role IN ( 'mother', 'father', 'guardian' )"

	has_many	:sent_notes, :foreign_key => :sender_id, :class_name => 'Note'
	
	has_many	:note_deliveries, :foreign_key => :recipient_id
	has_many	:received_notes, :through => :note_deliveries, :source => :note
		# I'm also going to alias that relationship because it's easier to type and understand
	has_many	:notes, :through => :note_deliveries, :source => :note

		# for kids, the assignemnts they have
	has_many	:objective_assignments
	has_many	:objectives, :through => :objective_assignments
	
	has_many	:checkins
	
		# for adults, objectives and assignments they've made
	has_many	:created_assignments, :class_name => 'ObjectiveAssignment', :foreign_key => :creator_id
	has_many	:created_objectives, :class_name => 'Objective', :foreign_key => :creator_id

	has_many	:wishlists
	has_many	:wishlist_items, :through => :wishlists

	has_many	:point_earnings
	has_many	:point_spendings

	has_many	:award_assignments
	has_many	:assigned_awards, :through => :award_assignments, :source => :award
	
	has_many	:achievement_earnings
	has_many	:achievements, :through => :achievement_earnings

	has_many	:ownings
	has_many	:awards, :through => :ownings, :source => :ownable, :class_name => 'Award'
	has_many	:unlockables, :through => :ownings, :source => :ownable, :class_name => 'Unlockable'
	
	has_many	:created_awards, :class_name => 'Award', :as => :creator

	has_many	:weekly_approvals, :as => :creator
	
	has_many	:journals
	
	has_many	:quizzings

	
	# Plugins	--------------------------------------
	has_friendly_id   :name, :use_slug => :true

	has_attached :avatar, :formats => ['jpg', 'gif', 'png'], :process => { :resize => {
				:profile  => "120",
				:thumb => "64",
				:tiny => "20"
				}}
	
	acts_as_taggable_on	:favorite_books
	acts_as_taggable_on	:favorite_movies_tv
	acts_as_taggable_on	:favorite_toys
	acts_as_taggable_on	:favorite_music
	
	acts_as_follower
	does_activities

	# Attribute accessors		------------------------------------
	attr_accessor	:password_confirmation

	# Class methods 	------------------------------------

	def self.authenticate( id, password )
		# going to tweak this to return the user(or false) along with a status msg
		# so, new use will be user, msg = User.authenticate( email, password )
		# also going to add the ability to login by username in addition to email
		user = User.find_by_email( id ) || User.find_by_name( id )
		
		if user.nil?
			return user, "Invalid user/password combination"
		elsif !user.registered?
			return false, "User not registered"
		else
			expected_password = encrypted_password( password, user.salt )
			if user.hashed_password != expected_password
				user = nil
				return user, "Invalid user/password combination"
			end
		end
		
		return user, "#{user.email} successfully logged in"
		
  	end

	def self.anonymous
		User.find ANONYMOUS_ID
	end

	# Instance Methods	------------------------------------
	
	# For sessions / Validations, etc..
		
	def anonymous?
		self.id == ANONYMOUS_ID
	end
	
	def create_activation_code
		self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
		self.save
	end
	
	def create_remember_token
		self.remember_token = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
		self.remember_token_expires_at = 1.day.from_now
		self.save
	end
	
	def has_email?
		!self.email.blank?
	end
	
	def has_name?
		self.name.present?
	end
	
	def has_password?
		self.password.present?
	end
	
		#ruby attribute names can't end with question marks, only method names, so I'll
		#write my own attr_writer and a custom attr_reader that ends with a ?
	def human=(val)
		@human=val
	end
  
	def human?
		@human
	end
	
	def logged_in?
		!self.anonymous?
	end
	
		#'password' is a virtual attribute i.e. not in the db
	def password
		@password
	end

	def password=(pwd)
		@password = pwd
		return if pwd.blank?
		create_new_salt
		self.hashed_password = User.encrypted_password(self.password, self.salt)
	end
	
	def registered?
		self.hashed_password.present?
	end
	
	def validated?
		!self.email.blank? && !self.activated_at.nil?
	end
	
	
	# For permissions / Roles
	
	def admin?( site )
		site.admins.include? self
	end
	
	def contributor?( site )
		contribs = site.contributors + site.admins
		contribs.include? self
	end
	
	def make_admin( site )
		r = Role.create :user_id => self.id, :site_id => site.id, :role => 'admin'
	end
	
	def make_contributor( site )
		r = Role.create :user_id => self.id, :site_id => site.id, :role => 'contributor'
	end
	
	def make_site_role( site, role )
		r = Role.create :user_id => self.id, :site_id => site.id, :role => role
	end
	
	# Stuff for Social Media ---------------------------------------------
		# Facebook -------------------------------------------------
	def facebook_user?
		!self.facebook_accounts.empty?
	end
	
	def social_accounts
		self.twitter_accounts + self.facebook_accounts
	end
	
		# Twitter --------------------------------------------------
	def twitter_user?
		!self.twitter_accounts.empty?
	end
	
	# App-specific
	
	def awards
		self.ownings.awards
	end
	
	def unlockables
		self.ownings.unlockables
	end
	
	
	def is_child?
		return self.type == 'Child'
	end
	
	alias :child? :is_child?
	
	def relation_to( user )
		self.relationships.find_by_related_user_id( user.id ).role
	end
	
	def nickname( user=nil )
		# nickname is defined in the relationship between users -- what one user calls another
		# if called without a user for the relationship, just returns the display_name
		if user.present?
			self.relationships.find_by_related_user_id( user.id ).nickname
		else
			self.display_name
		end
	end
	
	def relate_to( user, args={} )
		relationship = self.relationships.find_or_initialize_by_related_user_id( user.id )
		if args[:as].present? 
			role = args[:as]
		elsif relationship.role.present?
			role = relationship.role
		else
			role = 'relative'
		end
		if args[:nickname].present?
			nickname = args[:nickname]
		elsif relationship.nickname.present?
			nickname = relationship.nickname
		else
			nickname = self.display_name
		end
		relationship.attributes = { :role => role, :nickname => nickname }
		relationship.save
		return relationship, relationship.symmetric_relationship
	end
	
	def write_note( args={} )
		if note = self.sent_notes.create( :subject => args[:subject], :content => args[:content] )
			note.deliver_to( args[:to] )
		end
	end
	

	def get_unchecked_assignments
		assignments = self.objective_assignments.unchecked_for_today + self.objective_assignments.never_checked
	end

	
	def earn_points_for( obj, points=nil )
		# take an event object (message, check-in, activity, gam, quiz, etc.), create an earning transaction 
		# and add points to the user's point_balance and point_total
		points = obj.point_value if points.nil?
		self.point_earnings.create :earned_for_id => obj.id, :earned_for_type => obj.class.name, :points => points
		self.update_attributes :points_earned => ( self.points_earned + points ), :points_balance => ( self.points_balance + points )
	end
	
	def can_unlock?( award )
		return self.level >= award.level && self.points_balance >= award.points
	end
	
	def unlock( award )
		return false, "You can't unlock this yet" unless self.can_unlock?( award )
		self.awards << award
		self.update_attributes :points_balance => self.points_balance - award.points
		return true, "Unlocked!"
	end
	
	def play( game )
		self.games << game
		self.earn_points_for( game )
		self.do_activity( "Earned #{game.points} points for playing", game )
	end
	
	def owns?( award )
		self.awards.include?( award )
	end

	protected

	def set_avatar
		if self.has_email? && self.avatar.nil?
			photo_url = "http://gravatar.com/avatar/" + Digest::MD5.hexdigest( self.email ) + "?d=identicon"
			pic = Attachment.create( :path => photo_url, :attachment_type => 'avatar', :owner => self, :remote => true, :format => 'jpg' )
		end
	end
	
	def strip_website_url
		website_url.gsub!('http://', '') unless website_url.nil?
	end
	
	def set_name
		unless( self.name.present? || self.is_child? )
			if self.display_name.present?
				self.name = self.display_name.gsub( /\W/, "_" )
			else
				self.name = self.email.gsub( /\W/, "_" ) 
			end
		end
		self.display_name = self.name unless self.display_name.present?
	end
	
	
	
private

	def password_non_blank
		errors.add(:password, "Missing Password") if hashed_password.blank?
	end

	def create_new_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

	def self.encrypted_password(pw, salt)
		string_to_hash = pw + "439fgfg334gergersd9fhq34ufq" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end

	

end
