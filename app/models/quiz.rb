# == Schema Information
# Schema version: 20101127174142
#
# Table name: quizzes
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  point_value :integer(4)      default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class Quiz < ActiveRecord::Base
	has_many	:questions
	has_many	:quizzings

end
