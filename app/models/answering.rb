# == Schema Information
# Schema version: 20101127174142
#
# Table name: answerings
#
#  id          :integer(4)      not null, primary key
#  quizzing_id :integer(4)
#  question_id :integer(4)
#  answer_id   :integer(4)
#  response    :text
#  created_at  :datetime
#  updated_at  :datetime
#


class Answering < ActiveRecord::Base
	belongs_to	:quizzing
	belongs_to	:question
	belongs_to	:answer
end
