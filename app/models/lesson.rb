# == Schema Information
# Schema version: 20110420185439
#
# Table name: lessons
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  lesson_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Lesson < ActiveRecord::Base
	has_many	:lesson_screens
	has_many	:lesson_assignments
	has_many	:lesson_viewings
	has_many	:quizzes
	acts_as_taggable_on	:keywords
	
	
	def first_screen
		self.lesson_screens.find_by_sequence( 1 ) || self.lesson_screens.first
	end
	
	def last_screen
		self.lesson_screens.order( "sequence ASC" ).last || self.lesson_screens.last
	end
	
	
end
