# == Schema Information
# Schema version: 20101127174142
#
# Table name: quizzings
#
#  id          :integer(4)      not null, primary key
#  quiz_id     :integer(4)
#  taker_id    :integer(4)
#  taker_type  :string(255)
#  question_id :integer(4)
#  score       :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Quizzing < ActiveRecord::Base
	belongs_to	:quiz
	belongs_to	:taker, :polymorphic => true
	has_many	:answerings
	
	def answer( question, answer )
		# record the answer
		self.answerings.create :question => question, :answer => answer
	end

end
	
	
