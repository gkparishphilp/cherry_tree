# == Schema Information
# Schema version: 20110210211558
#
# Table name: quizzes
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  created_by_id :integer(4)
#  description   :text
#  point_value   :integer(4)      default(0)
#  level         :integer(4)
#  quiz_type     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Quiz < ActiveRecord::Base
	has_many	:questions, :dependent => :destroy
	
	accepts_nested_attributes_for	:questions, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	
	has_many	:quizzings
	
	def last_question
		self.questions.order( "seq ASC" ).last || self.questions.last
	end
	
	def first_question
		self.questions.find_by_seq( 1 ) || self.questions.first
	end
	
	def taken_by?( user )
		return self.quizzings.find_by_user_id( user )
	end
	
	def user_score( user )
		return self.quizzings.find_by_user_id( user ).score
	end
	
	
end
