# == Schema Information
# Schema version: 20110420185439
#
# Table name: lesson_screens
#
#  id         :integer(4)      not null, primary key
#  lesson_id  :integer(4)
#  content    :text
#  sequence   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class LessonScreen < ActiveRecord::Base
	belongs_to	:lesson
	has_attached :content_file
	
	def previous_screen
		self.lesson.lesson_screens.find_by_sequence( self.sequence - 1 )
	end
	
	def next_screen
		self.lesson.lesson_screens.find_by_sequence( self.sequence + 1 )
	end
end
