# == Schema Information
# Schema version: 20101209043322
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  type                      :string(255)
#  registered_by_id          :integer(4)
#  email                     :string(255)
#  name                      :string(255)
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
	validates	:password, :confirmation => true, :length => { :minimum => 4, :maximum => 254 }, :if => :has_password?

	validates	:email, :uniqueness => true, 
						:length => {:minimum => 3, :maximum => 254},
						:email => true,
						:if => :has_email?

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
	has_many	:twitter_accounts, 	:as => :owner
	has_many	:facebook_accounts,	:as => :owner
	
	has_many	:articles, :as => :owner
	
	has_many	:relations
	has_many	:supported_children, :through => :relations, :foreign_key => :child_id, :class_name => 'Child', :source => :child, :conditions => "role NOT IN ( 'mother', 'father', 'guardian', 'pro' )"
	has_many	:children, :through => :relations, :foreign_key => :child_id, :class_name => 'Child', :conditions => "role IN ( 'mother', 'father', 'guardian', 'pro' )"

	has_many	:received_messages, :as => :recipient, :class_name => 'Message'
	has_many	:sent_messages, :as => :sender, :class_name => 'Message'

	has_many	:assignments
	has_many	:objectives, :through => :assignments

	has_many	:earnings

	has_many	:ownings
	has_many	:unlockables, :through => :ownings

	has_many	:playings
	has_many	:games, :through => :playings

	has_many	:checkins

	has_many	:quizzings

	
	# Plugins	--------------------------------------
	has_friendly_id   :name, :use_slug => :true

	has_attached :avatar, :formats => ['jpg', 'gif', 'png'], :process => { :resize => {
				:profile  => "120",
				:thumb => "64",
				:tiny => "20"
				}}
	
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
	
	def relation_to( child )
		self.relations.find_by_child_id( child.id ).role
	end
	
	def earn_points_for( obj, points=nil )
		# take an event object (message, check-in, activity, gam, quiz, etc.), create an earning transaciton 
		# and add points to the user's point_balance and point_total
		points = obj.points if points.nil?
		self.earnings.create :earned_for_id => obj.id, :earned_for_type => obj.class.name, :points => points
		self.update_attributes :points_earned => ( self.points_earned + points ), :points_balance => ( self.points_balance + points )
	end
	
	def can_unlock?( unlockable )
		return self.level >= unlockable.level && self.points_balance >= unlockable.points
	end
	
	def unlock( unlockable )
		return false, "You can't unlock this yet" unless self.can_unlock?( unlockable )
		self.unlockables << unlockable
		self.update_attributes :points_balance => self.points_balance - unlockable.points
		return true, "Unlocked!"
	end
	
	def play( game )
		self.games << game
		self.earn_points_for( game )
		self.do_activity( "Earned #{game.points} points for playing", game )
	end
	
	def owns?( unlockable )
		self.unlockables.include?( unlockable )
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
		self.name = self.email.gsub(/\W/, "_") unless self.name.present?
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
