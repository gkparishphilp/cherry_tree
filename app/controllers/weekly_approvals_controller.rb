class WeeklyApprovalsController < ApplicationController
	
	def create
		
		@approval = @current_user.weekly_approvals.new( params[:weekly_approval] )

		if @approval.save
			pop_flash "Approved!"
		else
			pop_flash "Oooops, Not Approved", :error, @approval
		end		
		redirect_to :back
	end

end
