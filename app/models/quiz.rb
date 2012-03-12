
class Quiz < ActiveRecord::Base
	belongs_to	:lesson
	
	has_many	:quiz_assignments
	
	has_many	:quiz_questions, :dependent => :destroy
	
	accepts_nested_attributes_for	:quiz_questions, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	
	has_many	:quizzings
	
	def self.standalone
		where( "lesson_id is null ")
	end
	
	def last_question
		self.quiz_questions.order( "sequence ASC" ).last
	end
	
	def first_question
		self.quiz_questions.find_by_sequence( 1 ) || self.quiz_questions.first
	end
	
	def taken_by?( user )
		return self.quizzings.find_by_user_id( user )
	end
	
	def user_score( user )
		return self.quizzings.find_by_user_id( user ).score
	end
	
	def taken_by?( user )
		quiz = Quizzing.find_by_user_id_and_quiz_id( user.id, self.id )
		if quiz.present? and quiz.score.present?
			return true
		else
			return false
		end
	end
	
end
