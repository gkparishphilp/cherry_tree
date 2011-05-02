# == Schema Information
# Schema version: 20110420185439
#
# Table name: checkins
#
#  id                      :integer(4)      not null, primary key
#  user_id                 :integer(4)
#  content                 :string(255)
#  objective_assignment_id :integer(4)
#  confirmed_by            :integer(4)      default(0)
#  confirmed_at            :datetime
#  done                    :boolean(1)
#  created_at              :datetime
#  updated_at              :datetime
#

class Checkin < ActiveRecord::Base
	
	# confirmed_by = user_id of confirming user
	# confirmed_by == 0 is uncomfirmed
	# confrimed_by == -1 is ignored
	
	belongs_to	:user
	belongs_to	:objective_assignment
		
	
	scope :dated_between, lambda { |*args| 
		where( "checkins.created_at between ? and ?", args.first, args.second ) 
	}
	scope :by, lambda { |child| 
		where( "checkins.user_id = ?", child.id )
	}
	
	after_save :award_points
	
	scope :unapproved, joins("join objective_assignments on objective_assignments.id = checkins.objective_assignment_id").where("objective_assignments.req_confirm = 1 and checkins.confirmed_by = 0 and checkins.done is NOT NULL ")

	def unapproved?
		self.objective_assignment.req_confirm && self.done? && self.confirmed_by == 0
	end
	
	
	def award_points
		#award points for checkins that don't need confirmation
		if self.objective_assignment.present? && self.objective_assignment.req_confirm == false && self.done?
			self.user.earn_points_for( self.objective_assignment, self.objective_assignment.point_value)
		end
		
		#award points for checkins that need confirmation
		if self.objective_assignment.present? && self.objective_assignment.req_confirm == true && self.done? && self.confirmed_by > 0 
			self.user.earn_points_for( self.objective_assignment, self.objective_assignment.point_value)
		end
		
	end
	
	
end
