# == Schema Information
# Schema version: 20110203215818
#
# Table name: messagings
#
#  id           :integer(4)      not null, primary key
#  message_id   :integer(4)
#  recipient_id :integer(4)
#  unread       :boolean(1)      default(TRUE)
#  created_at   :datetime
#  updated_at   :datetime
#


class Messaging < ActiveRecord::Base
	belongs_to	:message
	belongs_to	:recipient, :class_name => 'User'
	
	scope :unread, where( 'unread is true' )
	scope :read, where( 'unread is false' )
end
