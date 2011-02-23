# == Schema Information
# Schema version: 20110210211558
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

	
	def self.exists_for?( assignment, week )
		week = week.end_of_week
		where( "objective_assignment_id = ? and week_ending = ?", assignment.id, week.getutc )
	end
	
	
	
end
