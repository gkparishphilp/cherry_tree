# == Schema Information
# Schema version: 20101127174142
#
# Table name: quizzes
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  point_value :integer(4)      default(0)
#  level       :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Quiz < ActiveRecord::Base
	has_many	:questions, :dependent => :destroy
	accepts_nested_attributes_for	:questions, :reject_if => lambda { |attrs| attrs[:content].blank? }, :allow_destroy => true
	
	has_many	:quizzings

end
