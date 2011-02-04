# == Schema Information
# Schema version: 20101209043322
#
# Table name: objectives
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  creator_id     :integer(4)
#  description    :text
#  objective_type :string(255)
#  due_at         :datetime
#  times          :integer(4)
#  period         :string(255)
#  req_checkin    :boolean(1)      default(TRUE)
#  req_confirm    :boolean(1)
#  points         :integer(4)      default(1)
#  level          :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class Objective < ActiveRecord::Base
	has_many	:assignments
	has_many	:users, :through => :assignments
	has_many	:earnings, :as => :earned_for
	has_many	:checkins
	
	attr_accessor	:user_id
	
	scope :recurring, where( "objective_type = 'recurring' " )
	scope :once, where( "objective_type = 'once' " )
	
	def earned_for_period
		start_time = self.get_period_start_time
		if self.earnings.dated_between(start_time, Time.now.getutc).count > 0
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
