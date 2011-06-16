# == Schema Information
# Schema version: 20110420185439
#
# Table name: quiz_assignments
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  quiz_id     :integer(4)
#  creator_id  :integer(4)
#  point_value :integer(4)      default(1)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#


class QuizAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:quiz
	
	
	def offered_today_to?( user )
		return false unless self.quiz.quizzings.find_by_user_id( user ).present?
		self.quiz.quizzings.find_by_user_id( user.id ).updated_at > Time.now.beginning_of_day
	end
	
end
