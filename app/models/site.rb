# == Schema Information
# Schema version: 20101209043322
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
	
	has_many :articles, :as => :owner
	
	has_many :links, :as => :owner
	has_many :twitter_accounts, :as => :owner
	has_many :facebook_accounts, :as => :owner

	has_many :static_pages
	has_many :contacts
	has_many :crashes
	
	gets_activities

end
