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
	has_many	:screens
	has_many	:lesson_assignments
	has_many	:lesson_viewings
	has_many	:quizzes
	acts_as_taggable_on	:keywords
	
	
	def first_screen
		self.screens.find_by_sequence( 1 ) || self.screens.first
	end
	
	def last_screen
		self.screens.order( "sequence ASC" ).last || self.screens.last
	end
	
	def completed_on_by( user )
		return false unless viewing = self.lesson_viewings.find_by_user_id( user.id )
		return viewing.updated_at
	end
	
	
end
