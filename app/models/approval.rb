# == Schema Information
# Schema version: 20110228224652
#
# Table name: approvals
#
#  id                      :integer(4)      not null, primary key
#  objective_assignment_id :integer(4)
#  creator_id              :integer(4)
#  week_ending             :date
#  status                  :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#

class Approval < ActiveRecord::Base
	belongs_to :objective_assignment
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
	scope :for_week, lambda {|*args|
		where(" approvals.created_at between ? and ?", args.first.beginning_of_week, args.first.end_of_week)
	}
	
	scope :dated_between, lambda { |*args| 
		where( "approvals.created_at between ? and ?", args.first, args.second ) 
	}
	 
	
end
