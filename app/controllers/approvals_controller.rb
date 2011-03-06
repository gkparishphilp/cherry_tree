class ApprovalsController < ApplicationController
	def new
		@approval = Approval.new
	end
	
	def create
		@approval = Approval.new 
		@checkin = Checkin.find params[:checkin]
		@approval.checkin = @checkin
		@approval.creator = @current_user
		@approval.status = 'approved'
		if @approval.save
			pop_flash "Approval saved!"
			@checkin.user.earn_points_for( @checkin, @checkin.objective_assignment.point_value / @checkin.objective_assignment.times )
			
		else
			pop_flash "Error"
		end
		redirect_to :back
	end
	
	def update
	end
	
	def create_many
		@assignment = ObjectiveAssignment.find params[:id]
		@assignment.approve_checkins_dated_between( params[:start_time], params[:end_time], @current_user )
		redirect_to :back
	end
	
end