# == Schema Information
# Schema version: 20110228224652
#
# Table name: answers
#
#  id          :integer(4)      not null, primary key
#  question_id :integer(4)
#  content     :text
#  correct     :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
	belongs_to	:quiz
	has_many	:answerings
	
	attr_accessor	:response #virtual attribute to log into answerings for free-response
end
