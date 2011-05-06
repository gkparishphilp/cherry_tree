
class QuizAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:quiz
	
	
	def offered_today_to?( user )
		return false unless self.quiz.quizzings.find_by_user_id( user ).present?
		self.quiz.quizzings.find_by_user_id( user.id ).updated_at > Time.now.beginning_of_day
	end
	
end