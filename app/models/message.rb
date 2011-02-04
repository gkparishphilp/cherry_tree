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
	has_many	:earnings, :as => :earned_for
	
	def send_to( user )
		self.messagings.create :recipient => user
	end
end
