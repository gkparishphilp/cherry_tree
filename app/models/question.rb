class Question < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:answers
	has_one		:correct_answer, :class_name => 'Answer', :conditions => "correct = true"

end