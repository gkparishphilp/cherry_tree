# == Schema Information
# Schema version: 20101209043322
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
end
