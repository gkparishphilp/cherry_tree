# == Schema Information
# Schema version: 20110420185439
#
# Table name: quizzes
#
#  id          :integer(4)      not null, primary key
#  lesson_id   :integer(4)
#  name        :string(255)
#  creator_id  :integer(4)
#  description :text
#  point_value :integer(4)      default(0)
#  level       :integer(4)
#  quiz_type   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Quiz < ActiveRecord::Base
	belongs_to	:lesson
	
	has_many	:quiz_assignments
	
	has_many	:questions, :dependent => :destroy
	
	accepts_nested_attributes_for	:questions, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	
	has_many	:quizzings
	
	def self.standalone
		where( "lesson_id is null ")
	end
	
	def last_question
		self.questions.order( "sequence ASC" ).last || self.questions.last
	end
	
	def first_question
		self.questions.find_by_sequence( 1 ) || self.questions.first
	end
	
	def user_score( user )
		return self.quizzings.find_by_user_id( user ).score
	end
	
	def taken_by?( user )
		quiz = Quizzing.find_by_user_id_and_quiz_id(user.id, self.id)
		if quiz.present? and quiz.score.present?
			return true
		else
			return false
		end
	end
	
end
