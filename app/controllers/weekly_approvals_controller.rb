class WeeklyApprovalsController < ApplicationController
	
	def create
		
		@approval = @current_user.weekly_approvals.new( params[:weekly_approval] )
		
		# bail if an approval already exists for this week and assignment
		
		if @approval.save
			percent = 1.0
			case @approval.status
			when 'good' 
				percent = 0.5
			when 'no good' 
				percent = 0.0
			end
			
			@approval.objective_assignment.user.earn_points_for( @approval, @approval.objective_assignment.point_value * percent )
			
			pop_flash "Approved!"
		else
			pop_flash "Oooops, Not Approved", :error, @approval
		end		
		redirect_to :back
	end

end
