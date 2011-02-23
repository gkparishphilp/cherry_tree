# == Schema Information
# Schema version: 20110221232318
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  site_id    :integer(4)
#  user_id    :integer(4)
#  subject    :string(255)
#  ip         :string(255)
#  crash_id   :integer(4)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
	belongs_to :crash
	belongs_to :user
	
	validates_presence_of :subject, :message => "Please provide a subject"
	validates_presence_of :content, :message => "You should have something to say to contact us ;-)"
	
	
	attr_accessor :email
end
