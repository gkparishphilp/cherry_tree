class AwardAssignmentsController < ApplicationController
	before_filter :get_child
	
	
	def create
		@assignment = @current_user.created_award_assignments.new( params[:award_assignment] )
		@assignment.user = @child
		if @assignment.save
			pop_flash "Assignment Made"
		else
			pop_flash "There was a problem with the assignment", :error, @assignment
		end
		redirect_to child_award_assignments_path( @child )
	end
	
	def index
		@assignments = @child.award_assignments
		@awards = @current_user.created_awards.map{ |award| 
			[ "#{award.name} - #{award.award_type} (#{award.point_cost})", award.id ]
			}
		
		@new_assignment = @child.award_assignments.new
	end
	
	def new
		@assignment = AwardAssignment.new
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end