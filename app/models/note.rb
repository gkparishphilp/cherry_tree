# == Schema Information
# Schema version: 20110420185439
#
# Table name: notes
#
#  id            :integer(4)      not null, primary key
#  sender_id     :integer(4)
#  font_id       :integer(4)
#  background_id :integer(4)
#  border_id     :integer(4)
#  font_color    :string(255)     default("#333")
#  subject       :string(255)
#  content       :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Note < ActiveRecord::Base
	belongs_to	:sender, :class_name => 'User'
	has_many	:note_deliveries
	has_many	:recipients, :through => :note_deliveries

	belongs_to	:font
	belongs_to	:background
	belongs_to	:border
	
	has_many	:page_elements, :as => :page
	

	validates_presence_of :content, :message => "Type a message before clicking 'Send'!"
	
	attr_accessor	:recipient_id # so we can set the recipient int he form without form_tag
	
	def deliver_to( user )
		if delivery = self.note_deliveries.find_by_recipient_id( user.id )
			# if this is a resend of an existing note, set it to nuread and undeleted
			delivery.update_attributes :unread => false, :status => 'resent'
		else
			# create a new delivery to the recipient
			self.note_deliveries.create :recipient => user
		end
	end
	
	def delivery_for( user )
		self.note_deliveries.find_by_recipient_id( user.id )
	end
	
	def mark_deleted_by( user )
		if delivery = self.note_deliveries.find_by_recipient_id( user.id )
			delivery.update_attributes :status => 'deleted'
		end
	end
	
	def mark_read_by( user )
		if delivery = self.note_deliveries.find_by_recipient_id( user.id )
			delivery.update_attributes :unread => false
		end
	end
	
	
	def css
		font_class = self.font.present? ? self.font.css_class : 'font_plain'
		bg_class = self.background.present? ? self.background.css_class : 'bg_plain'
		return font_class + " " + bg_class
	end
	

	
	
end
