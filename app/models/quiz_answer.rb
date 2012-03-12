
class QuizAnswer < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:quiz_answerings
	
	attr_accessor	:response # virtual attribute to log into answerings for free-response
end
