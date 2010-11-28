# == Schema Information
# Schema version: 20101127174142
#
# Table name: questions
#
#  id            :integer(4)      not null, primary key
#  quiz_id       :integer(4)
#  content       :text
#  extra_content :string(255)
#  point_value   :integer(4)      default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

class Question < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:answers
	has_one		:correct_answer, :class_name => 'Answer', :conditions => "correct = true"

end
