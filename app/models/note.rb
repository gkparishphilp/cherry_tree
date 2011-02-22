# == Schema Information
# Schema version: 20110210211558
#
# Table name: notes
#
#  id               :integer(4)      not null, primary key
#  sender_id        :integer(4)
#  font             :string(255)     default("schoolbell")
#  font_color       :string(255)     default("#333")
#  background_color :string(255)     default("#ffd")
#  subject          :string(255)
#  content          :text
#  created_at       :datetime
#  updated_at       :datetime
#

class Note < ActiveRecord::Base
	belongs_to	:sender, :class_name => 'User'
	has_many	:note_deliveries
	has_many	:recipients, :through => :note_deliveries
	has_many	:point_earnings, :as => :earned_for

	validates_presence_of :content, :message => "You should have something to say ;-)"
	
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
	
	
	
	def font_class
		# the font name as a CSS class (just whitespace to underscores)
		self.font.gsub( /\s/, "_" )
	end
	
	def font_css
		# the font name as appropriate for linking in the stylesheet:
		# e.g. stylesheet_link_tag 'http://fonts.googleapis.com/css?family=Homemade+Apple'
		self.font.gsub( /\s/, "+" )
	end
	
	
end
