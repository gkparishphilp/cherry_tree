class ApprovalsController < ApplicationController
	before_filter :get_child
	
	def index
		@checkins = @child.checkins #todo -- that haven't been approved
	end
	
	def create
		@approval = Approval.new params[:approval]
		@approval.creator = @current_user

		if @approval.save
			pop_flash "Approval saved!"
			@approval.objective_assignment.user.earn_points_for( @approval.objective_assignment, @approval.objective_assignment.point_value )
		else
			pop_flash "Error"
		end
		redirect_to :back
	end

	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end