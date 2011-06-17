# == Schema Information
# Schema version: 20110420185439
#
# Table name: sites
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  domain     :string(255)
#  status     :string(255)     default("active")
#  created_at :datetime
#  updated_at :datetime
#

class Site < ActiveRecord::Base
	
	validates :domain, :uniqueness => true
	
	has_many :roles
	has_many :admins, :through => :roles, :source => :user, :conditions => "role = 'admin'"
	has_many :contributors, :through => :roles, :source => :user, :conditions => "role = 'contributor'"
	
	
	has_many :links, :as => :owner
	has_many :twitter_accounts, :as => :owner
	has_many :facebook_accounts, :as => :owner
	
	has_many	:created_awards, :as => :creator, :class_name => 'Award'
	has_many	:created_objectives, :as => :creator, :class_name => 'Objective'

	has_many :static_pages
	has_many :contacts
	has_many :crashes
	

end
