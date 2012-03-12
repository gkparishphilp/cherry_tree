
class Lesson < ActiveRecord::Base
	has_many	:lesson_screens
	has_many	:lesson_assignments
	has_many	:lesson_viewings
	has_many	:quizzes
	
	
	def first_screen
		self.lesson_screens.find_by_sequence( 1 ) || self.screens.first
	end
	
	def last_screen
		self.lesson_screens.order( "sequence ASC" ).last || self.screens.last
	end
	
	def completed_on_by( user )
		return false unless viewing = self.lesson_viewings.find_by_user_id( user.id )
		return viewing.updated_at
	end
	
	
end
