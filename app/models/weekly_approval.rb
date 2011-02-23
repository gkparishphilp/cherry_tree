# == Schema Information
# Schema version: 20110221232318
#
# Table name: weekly_approvals
#
#  id                      :integer(4)      not null, primary key
#  objective_assignment_id :integer(4)
#  creator_id              :integer(4)
#  week_ending             :date
#  status                  :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#

class WeeklyApproval < ActiveRecord::Base
	belongs_to	:objective_assignment
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'

	scope :for_assignment, lambda { |assignment| 
		where( "objective_assignment_id = ?", assignment.id )
	}
	
	scope :for_week_ending, lambda { |week|
		where( "week_ending like ?", week.end_of_week.strftime("%Y-%m-%d") )
	}
	
	
	
	
end
