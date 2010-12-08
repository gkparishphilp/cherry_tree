# == Schema Information
# Schema version: 20101208063306
#
# Table name: quizzings
#
#  id          :integer(4)      not null, primary key
#  quiz_id     :integer(4)
#  user_id     :integer(4)
#  question_id :integer(4)
#  score       :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Quizzing < ActiveRecord::Base
	belongs_to	:quiz
	belongs_to	:user
	has_many	:answerings
	
	def answer( question, answer )
		# record the answer
		self.update_attributes :question_id => question
		self.answerings.create :question => question, :answer => answer
	end

end
	
	
