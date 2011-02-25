class AwardAssignmentsController < ApplicationController
	before_filter :get_child
	
	
	def create
		@assignment = @current_user.created_assignments.new( params[:award_assignment] )
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
		@new_assignemnt = @child.award_assignments.new
	end
	
	def new
		@assignment = AwardAssignment.new
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end