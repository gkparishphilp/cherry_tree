class ApprovalsController < ApplicationController
	def new
		@approval = Approval.new
	end
	
	def create
		@approval = Approval.new params[:approval]
		@approval.creator = @current_user

		case @approval.status
			when 'good'
				multiplier = 1.0
			when 'ok'
				multiplier = 0.5
			when 'bad'
				multiplier = 0.0
		end
				
		if @approval.save
			pop_flash "Approval saved!"
			@approval.objective_assignment.user.earn_points_for( @approval.objective_assignment, @approval.objective_assignment.point_value * multiplier )
			
		else
			pop_flash "Error"
		end
		redirect_to :back
	end
	
	def update
	end
	
end