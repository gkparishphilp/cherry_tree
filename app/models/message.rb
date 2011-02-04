# == Schema Information
# Schema version: 20110203215818
#
# Table name: messages
#
#  id         :integer(4)      not null, primary key
#  sender_id  :integer(4)
#  subject    :string(255)
#  content    :text
#  points     :integer(4)      default(0)
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
	belongs_to	:sender, :class_name => 'User'
	has_many	:messagings
	has_many	:recipients, :through => :messagings
	has_many	:earnings, :as => :earned_for

	validates_presence_of :content, :message => "You should have something to say ;-)"
	
	attr_accessor	:recipient_id # so we can set the recipient int he form without form_tag
	
	def deliver_to( user )
		self.messagings.create :recipient => user
	end
end
