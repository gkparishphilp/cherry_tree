# == Schema Information
# Schema version: 20110228224652
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
#  req_confirm  :boolean(1)      default(TRUE)
#  point_value  :integer(4)      default(1)
#  status       :string(255)     default("active")
#  created_at   :datetime
#  updated_at   :datetime
#

class ObjectiveAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
	
	has_many	:point_earnings, :as => :earned_for
	has_many	:checkins
	has_many	:approvals
	
	attr_accessor	:objective_name, :objective_description # so we can create objectives from the objective_assignment screen
	
	scope :available, where("status <> 'deleted'")
	scope :active, where("status = 'active'")

	def checkin_in_last?( period = 1.day.ago)
		if self.checkins.dated_between(period, Time.now).present?
			return true
		else
			return false
		end
	end
	
	def earned_for_period
		start_time = self.get_period_start_time
		if self.point_earnings.dated_between(start_time, Time.now).count > 0
			return true
		else
			return false
		end
	end
	
	def get_period_start_time
		case self.period
		when 'day'
			start_time = Time.now.beginning_of_day
		when 'week'
			start_time = Time.now.beginning_of_week
		when 'month'
			start_time = Time.now.beginning_of_month
		when nil
			start_time = nil
		end
	end
	
	def approve_checkins_dated_between( start_time, end_time, approver )
		for checkin in self.checkins.dated_between(start_time, end_time)
			checkin.approval.present? ? checkin.approval.status = 'approved' : Approval.create( :checkin_id => checkin.id, :creator_id => approver.id, :status => 'approved' )
		end
	end
	
	def approved_for_week(week)
		self.approvals.for_week(week).count > 0 ? true : false
	end
	
end
