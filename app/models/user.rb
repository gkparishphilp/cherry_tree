# == Schema Information
# Schema version: 20110420185439
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
#  points_earned             :integer(4)      default(100)
#  point_balance             :integer(4)      default(100)
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
#  status                    :string(255)     default("first")
#  cached_slug               :string(255)
#  orig_ip                   :string(255)
#  last_ip                   :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#


require 'digest/sha1'

class User < ActiveRecord::Base
	
	# App -Specific Modules
	include UserAchievements
	
	include UserApp  # misc stuff not broken into module yet
	
	# Constants    --------------------------------------

	# Filters		--------------------------------------

		# Order of filter invocation:
		# before_validation
		# before_validation_on_update or before_validation_on_create
		# validate
		# validate_on_update or validate_on_create
		# after_validation
		# after_validation_on_update or after_validation_on_create
		# before_save
		# before_update or before_create
		# after_update or after_create
		# after_save

	before_validation		:set_name
	after_create			:set_avatar
  
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
	
	has_many	:activities


	# Testing robust relationships
	has_many	:relationships
	has_many	:related_users, :through => :relationships
	has_many	:relatives, :through => :relationships, 
							:source => :related_user, 
							:conditions => "role IN ( 'son', 'daughter', 'mother', 'father', 'guardian', 'brother',
							'sister', 'aunt', 'uncle', 'niece', 'nephew','cousin', 'grandmother', 'grandfather',
							'grandson', 'granddaughter', 'relative', 'stepmother', 'stepfather' ) and relationships.status = 'active'"
	has_many	:children, :through => :relationships, 
							:foreign_key => :related_user_id, 
							:class_name => 'Child', 
							:source => :related_user, 
							:conditions => "role IN ( 'mother', 'father', 'guardian' ) and relationships.status = 'active'"
	has_many	:supported_children, :through => :relationships, 
									:foreign_key => :related_user_id, 
									:class_name => 'Child', 
									:source => :related_user, 
									:conditions => "role NOT IN ( 'mother', 'father', 'guardian' ) and relationships.status = 'active'"

	# User is the subject of the sentence.  User(child) has parents and he/she is their 'son/daughter'
	has_many	:parents, :through => :relationships,
						:source => :related_user, 
						:conditions => "role IN ( 'son', 'daughter', 'ward', 'client') and relationships.status = 'active'"

	has_many	:sent_notes, :foreign_key => :sender_id, :class_name => 'Note'
	
	has_many	:note_deliveries, :foreign_key => :recipient_id
	has_many	:received_notes, :through => :note_deliveries, :source => :note
		# I'm also going to alias that relationship because it's easier to type and understand
	has_many	:notes, :through => :note_deliveries, :source => :note



		# for kids, the assignemnts they have
	has_many	:objective_assignments
	has_many	:objectives, :through => :objective_assignments
	
	def active_assigned_objectives
		self.objectives.joins( :objective_assignments ).where( "objective_assignments.status = 'active'" )
	end
	
	
	has_many	:checkins
	
		# for adults, objectives and assignments they've made
	has_many	:created_objective_assignments, :class_name => 'ObjectiveAssignment', :foreign_key => :creator_id
	has_many	:created_objectives, :class_name => 'Objective', :foreign_key => :creator_id

	has_many	:wishlists
	has_many	:wishlist_items, :through => :wishlists

	has_many	:point_earnings
	has_many	:point_spendings

	has_many	:award_assignments
	# Awards that are available to the child
	has_many	:assigned_awards, :through => :award_assignments, :source => :award
	
	def active_assigned_awards
		self.assigned_awards.joins( :award_assignments ).where( "award_assignments.status = 'active'" )
	end
	
		# for adults, awards and assignments they've made
	has_many	:created_award_assignments, :class_name => 'AwardAssignment', :foreign_key => :creator_id
	has_many	:created_awards, :class_name => 'Award', :foreign_key => :creator_id
	
	has_many	:achievement_earnings
	has_many	:achievements, :through => :achievement_earnings
	
	has_many	:lesson_assignments
	has_many	:lessons, :through => :lesson_assignments
	has_many	:lesson_viewings

	has_many	:ownings
	# putting these here because they act like relations, but you can't have a :through relation on a polymorphic object
	def awards
		self.ownings.awards
	end
	
	def unlockables
		self.ownings.unlockables
	end
	
	def stickers
		self.ownings.stickers
	end
	
	has_many	:created_awards, :class_name => 'Award', :as => :creator

	has_many	:weekly_approvals, :foreign_key => :creator_id
	has_many	:approvals, :foreign_key  => :creator_id
	
	has_many	:journals
	has_many	:journal_entries, :through => :journals
	
	has_many	:photo_albums
	has_many	:photos, :through => :photo_albums
	
	has_many	:quizzings
	has_many	:quiz_assignments

	has_many	:invitations
	has_many	:sent_invitations, :class_name => 'Invitation', :foreign_key => :creator_id
	
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
		User.first
	end


	# Attribute accessors		------------------------------------
	attr_accessor	:password_confirmation

	# Instance Methods	------------------------------------
	# For sessions / Validations, etc..
		
	def anonymous?
		self.id == 1
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
	
	def has_default?( name )
		if name == self.email.gsub( /\W/, "_" ) 
			return true
		else
			return false
		end
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
	
	def pronoun_gender_possessive
		return 'their' if self.gender.blank?
		self.gender == 'male' ? 'his' : 'her'
	end
	
	def pronoun_gender_subject
		return 'they' if self.gender.blank?
		self.gender == 'male' ? 'he' : 'she'
	end
	
	def pronoun_gender_object
		return 'them' if self.gender.blank?
		self.gender == 'male' ? 'him' : 'her'
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
	
	
	
	def do_activity( verb, target=nil )
		return self.activities.create :verb => verb, :target => target unless duplicate_activity?( verb, target, 5.minutes.ago )
	end
	
	def duplicate_activity?( verb, target, since )
		if target.present?
			count = Activity.active.recent( since ).where( "activities.user_id = ? AND activities.target_id = ? AND activities.target_type = ? AND verb = ? ", 
				self.id, target.id, target.class.name, verb ).count
		else
			count = Activity.active.recent( since ).where( "activities.user_id = ? AND verb = ? ", self.id, verb ).count
		end
		return 0 < count
	end
	

	protected

	def set_avatar
		if self.has_email? && self.avatar.nil?
			photo_url = "http://gravatar.com/avatar/" + Digest::MD5.hexdigest( self.email ) + "?d=identicon"
			pic = Attachment.create( :path => photo_url, :attachment_type => 'avatar', :owner => self, :remote => true, :format => 'jpg' )
		end
	end
	
	def setup_default_photo_album
		self.photo_albums.create :title => 'Default'
	end
	
	def strip_website_url
		website_url.gsub!('http://', '') unless website_url.nil?
	end
	
	def set_name
		unless( self.name.present? || self.is_child? )
			if self.display_name.present?
				self.name = self.display_name.gsub( /\W+/, "_" )
			else
				self.name = self.email.gsub( /\W+/, "_" ) 
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
