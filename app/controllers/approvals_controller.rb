class ApprovalsController < ApplicationController
	def new
		@approval = Approval.new
	end
	
	def create
		@approval = Approval.new params[:approval]
		if @approval.save
			pop_flash "Approval saved!"
		else
			pop_flash "Error"
		end
		redirect_to :back
	end
	
	def update
	end
	
end