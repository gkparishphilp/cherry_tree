
class QuizQuestion < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:quiz_answers, :dependent => :destroy
	has_many	:quiz_answerings
	
	accepts_nested_attributes_for	:quiz_answers, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	has_one		:correct_answer, :class_name => 'QuizAnswer', :conditions => "correct = true"
	
	after_create :set_sequence

	def next_question
		self.quiz.quiz_questions.find_by_sequence( self.sequence + 1 )
	end
	
	private 
	
	def set_sequence
		return if self.sequence.present?
		if self.quiz.quiz_questions.count < 2
			self.sequence = 1
		else
			self.sequence = self.quiz.last_question.sequence + 1
		end
		self.save
	end
end
