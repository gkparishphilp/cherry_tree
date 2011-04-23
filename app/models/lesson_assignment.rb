class LessonAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:lesson
	
	def completed?
		self.status == 'completed' ? (return true) : (return false)
	end
end