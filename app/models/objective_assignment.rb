# == Schema Information
# Schema version: 20110221232318
#
# Table name: objective_assignments
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  objective_id :integer(4)
#  creator_id   :integer(4)
#  times        :integer(4)
#  due_at       :datetime
#  period       :string(255)
#  req_checkin  :boolean(1)      default(TRUE)
#  req_confirm  :boolean(1)
#  point_value  :integer(4)      default(1)
#  created_at   :datetime
#  updated_at   :datetime
#

class ObjectiveAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
	
	has_many	:point_earnings, :as => :earned_for
	has_many	:checkins
	has_many	:weekly_approvals

	def checkin_in_last?( period = 1.day.ago)
		if self.checkins.dated_between(period.getutc, Time.now.getutc).present?
			return true
		else
			return false
		end
	end
	
	def earned_for_period
		start_time = self.get_period_start_time
		if self.point_earnings.dated_between(start_time, Time.now.getutc).count > 0
			return true
		else
			return false
		end
	end
	
	def get_period_start_time
		case self.period
		when 'day'
			start_time = Time.now.beginning_of_day.getutc
		when 'week'
			start_time = Time.now.beginning_of_week.getutc
		when 'month'
			start_time = Time.now.beginning_of_month.getutc
		when nil
			start_time = nil
		end
	end
	

end
