class InvitationsController < ApplicationController

	def create
		@email = params[:email]
		
		pop_flash "Invitation sent to #{@email}"
		redirect_to :back
	end
end