class ApprovalsController < ApplicationController
	def new
		@approval = Approval.new
	end
	
	def create
		@approval = Approval.new params[:approval]
		@approval.creator = @current_user

		case @approval.status
			when 'green'
				multiplier = 1.0
			when 'yellow'
				multiplier = 0.5
			when 'red'
				multiplier = 0.0
		end
				
		if @approval.save
			pop_flash "Approval saved!"
			@approval.objective_assignment.user.earn_points_for( @approval.objective_assignment, @approval.objective_assignment.point_value / @approval.objective_assignment.times * multiplier )
			
		else
			pop_flash "Error"
		end
		redirect_to :back
	end
	
	def update
	end
	
end