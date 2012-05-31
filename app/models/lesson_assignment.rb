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
#  created_at  :datetime
#  updated_at  :datetime
#

class LessonAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:lesson
	scope :active, where( "status = 'active'" )
	
	def completed_by?( user )
		#Completed by means that the quizzing for the lesson has a 'complete' status
		if self.lesson.quizzes.present? && quizzing = self.lesson.quizzes.last.quizzings.last #Some lessons don't have quizzes
			if quizzing.present? && quizzing.status == 'complete'
				return true
			else
				return false
			end
		else
			return false
		end
	end
	
	def offered_today_to?( user )
		return false unless self.lesson.lesson_viewings.find_by_user_id( user ).present?
		self.lesson.lesson_viewings.find_by_user_id( user.id ).updated_at > Time.now.beginning_of_day
	end
	
end
