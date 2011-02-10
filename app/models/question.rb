# == Schema Information
# Schema version: 20110210211558
#
# Table name: questions
#
#  id            :integer(4)      not null, primary key
#  quiz_id       :integer(4)
#  content       :text
#  extra_content :string(255)
#  points        :integer(4)      default(0)
#  seq           :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class Question < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:answers, :dependent => :destroy
	has_many	:answerings
	
	accepts_nested_attributes_for	:answers, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	has_one		:correct_answer, :class_name => 'Answer', :conditions => "correct = true"
	
	after_create :set_seq

	def next_question
		self.quiz.questions.find_by_seq( self.seq + 1 )
	end
	
	private 
	
	def set_seq
		return if self.seq.present?
		if self.quiz.questions.count < 2
			self.seq = 1
		else
			self.seq = self.quiz.last_question.seq + 1
		end
		self.save
	end
end
