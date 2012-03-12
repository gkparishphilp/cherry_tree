
class LessonAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:lesson
	
	def completed_by?( user )
		return false unless self.lesson.lesson_viewings.find_by_user_id( user ).present?
		self.lesson.lesson_viewings.find_by_user_id( user ).screen_id == self.lesson.screens.count
	end
	
	def offered_today_to?( user )
		return false unless self.lesson.lesson_viewings.find_by_user_id( user ).present?
		self.lesson.lesson_viewings.find_by_user_id( user.id ).updated_at > Time.now.beginning_of_day
	end
	
end
