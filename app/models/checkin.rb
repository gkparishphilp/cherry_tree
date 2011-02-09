# == Schema Information
# Schema version: 20110207173417
#
# Table name: checkins
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  content      :string(255)
#  objective_id :integer(4)
#  status       :string(255)     default("did_not")
#  confirmed_by :integer(4)
#  confirmed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Checkin < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective
	
	scope :update, where( "objective_id is null" )
	scope :positive, where('status = ?', 'did')
	scope :dated_between, lambda { |*args| 
		where( "created_at between ? and ?", args.first, args.second ) 
	}
	
	def expanded_status
		return self.status.gsub( /_/, " " )
	end
	
	def number_checkin_times
		start_time = self.objective.get_period_start_time

		if start_time.present?
			return num_checkins = objective.checkins.dated_between(Time.now.beginning_of_day.getutc, Time.now.getutc).positive.count
		else
			return 0
		end
	end
	
	def process_checkin
		if self.number_checkin_times >= self.objective.times
			if self.objective.earned_for_period
				pop_msg = "Way to overachieve!  You've exceeded your goal of #{self.objective.times} checkins for #{self.objective.name}"
			else
				pop_msg = "Congratulations! You've reached your goal of #{self.objective.times} checkins for #{self.objective.name}"				
				self.user.earn_points_for(self.objective, self.objective.points) 
			end
		else	
			if self.number_checkin_times == self.objective.times - 1
				pop_msg = "Almost there!  Only one more to go!"
			else
				pop_msg = "Awesome!  You have #{self.number_checkin_times} checkins so far this #{self.objective.period}.  Keep it up!"
			end
		end
		
		return pop_msg
	end
end
