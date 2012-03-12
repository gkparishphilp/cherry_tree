
class LessonScreen < ActiveRecord::Base
	belongs_to		:lesson
	has_attached 	:content_file
	
	def previous_screen
		self.lesson.screens.find_by_sequence( self.sequence - 1 )
	end
	
	def next_screen
		self.lesson.screens.find_by_sequence( self.sequence + 1 )
	end
end
