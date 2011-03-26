# == Schema Information
# Schema version: 20110228224652
#
# Table name: checkins
#
#  id                      :integer(4)      not null, primary key
#  user_id                 :integer(4)
#  content                 :string(255)
#  objective_assignment_id :integer(4)
#  status                  :string(255)     default("red")
#  confirmed_by            :integer(4)
#  confirmed_at            :datetime
#  created_at              :datetime
#  updated_at              :datetime
#

class Checkin < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective_assignment
		
	scope :update, where( "objective_assignment_id is null" )
	
	scope :good, where("status = 'good'")
	scope :ok, where("status = 'ok'")
	scope :bad, where("status = 'bad'")
	
	scope :dated_between, lambda { |*args| 
		where( "checkins.created_at between ? and ?", args.first, args.second ) 
	}
	scope :by, lambda { |child| 
		where( "checkins.user_id = ?", child.id )
	}
	
	def multiplier
		case self.status
			when 'good'
				return 1.0
			when 'ok'
				return 0.5
			when 'bad'
				return 0.0
		end
	end
		
	def expanded_status
		case self.status
			when 'bad'
				phrase = 'needs to work on'
			when 'ok'
				phrase = 'did an OK job'
			when 'good'
				phrase = 'did a great job'
		end
		return phrase
	end
	
	def number_checkin_times(period = 'week')
		if period == 'day'
			start = Time.now.beginning_of_day
		else
			start = Time.now.beginning_of_week
		end
		
		start_time = self.objective_assignment.get_period_start_time

		if start_time.present?
			return num_checkins = self.objective_assignment.checkins.dated_between(start, Time.now).count
		else
			return 0
		end
	end
	
	def get_banner_message
		if self.objective_assignment.checkins.dated_between(Time.now.beginning_of_week, Time.now).count > self.objective_assignment.times
			pop_msg = "Way to overachieve!  You've exceeded your goal of #{self.objective_assigment.times} green checkins for #{self.objective_assignment.objective.name}"
		elsif self.objective_assignment.checkins.dated_between(Time.now.beginning_of_week, Time.now).count == self.objective_assignment.times
			pop_msg = "Congratulations! You've reached your goal of #{self.objective_assignment.times} checkins for #{self.objective_assignment.objective.name}"
		elsif self.objective_assignment.checkins.dated_between(Time.now.beginning_of_week, Time.now).count == (self.objective_assignment.times - 1) && self.objective_assignment.times != 1
			pop_msg = "Almost there!  Only one more to go!"
		else
			pop_msg = "Awesome!  You have #{self.objective_assignment.checkins.dated_between(Time.now.beginning_of_week, Time.now).count} green checkins so far this #{self.objective_assignment.period}.  Keep it up!"
		end
		return pop_msg
	end
	
	def award_points
		#award points for checkins that don't need confirmation
		if self.objective_assignment.present? && self.objective_assignment.req_confirm == false
			self.user.earn_points_for( self.objective_assignment, self.objective_assignment.point_value / self.objective_assignment.times * self.multiplier)
		end	

	end
	
	def approved?
		self.approval.present? ? true : false
	end
	
	def not_approved?
		self.approval.nil? ? true : false
	end
	
end
