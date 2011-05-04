# == Schema Information
# Schema version: 20110420185439
#
# Table name: screens
#
#  id         :integer(4)      not null, primary key
#  lesson_id  :integer(4)
#  title      :string(255)
#  content    :text
#  sequence   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Screen < ActiveRecord::Base
	belongs_to		:lesson
	has_attached 	:content_file
	
	def previous_screen
		self.lesson.screens.find_by_sequence( self.sequence - 1 )
	end
	
	def next_screen
		self.lesson.screens.find_by_sequence( self.sequence + 1 )
	end
end
