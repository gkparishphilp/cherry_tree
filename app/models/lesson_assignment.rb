# == Schema Information
# Schema version: 20110420185439
#
# Table name: lesson_assignments
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  lesson_id   :integer(4)
#  creator_id  :integer(4)
#  point_value :integer(4)      default(1)
#  status      :string(255)
#

class LessonAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:lesson
	
	def completed?
		self.status == 'completed' ? (return true) : (return false)
	end
end
