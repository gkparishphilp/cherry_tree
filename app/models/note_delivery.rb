# == Schema Information
# Schema version: 20110420185439
#
# Table name: note_deliveries
#
#  id           :integer(4)      not null, primary key
#  note_id      :integer(4)
#  recipient_id :integer(4)
#  unread       :boolean(1)      default(TRUE)
#  status       :string(255)     default("active")
#  created_at   :datetime
#  updated_at   :datetime
#


class NoteDelivery < ActiveRecord::Base
	belongs_to	:note
	belongs_to	:recipient, :class_name => 'User'
	
	delegate	:sender, :to => :note
	
	scope :unread, where( "unread is true" )
	scope :read, where( "unread is false" )
	
	scope :published, where( "status != 'deleted'" )
	scope :deleted, where( "status = 'deleted'" )
	
end
