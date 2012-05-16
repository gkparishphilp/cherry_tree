# == Schema Information
# Schema version: 20110420185439
#
# Table name: questions
#
#  id            :integer(4)      not null, primary key
#  quiz_id       :integer(4)
#  content       :text
#  extra_content :string(255)
#  point_value   :integer(4)      default(0)
#  sequence      :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class Question < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:answers, :dependent => :destroy
	has_many	:answerings
	
	accepts_nested_attributes_for	:answers, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	has_one		:correct_answer, :class_name => 'Answer', :conditions => "correct = true"
	
	after_create :set_sequence

	def next_question
		self.quiz.questions.find_by_sequence( self.sequence + 1 )
	end
	
	def answered_by( user )
		self.answerings.joins(:quizzings).where("quizzings.user_id = ?", user.id)
	end
	
	private 
	
	def set_sequence
		return if self.sequence.present?
		if self.quiz.questions.count < 2
			self.sequence = 1
		else
			self.sequence = self.quiz.last_question.sequence + 1
		end
		self.save
	end

end
