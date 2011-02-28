class InvitationsController < ApplicationController
	
	def new
		@invitation = Invitation.new
	end
	
	def create	
		
		@invitation = Invitation.new params[:invitation]
		
		# Create a user entry and relationship
		if @invitee = User.find_or_initialize_by_email( :email => @email) and @invitation.setup( @current_user, @invitee)
				@invitee.relate_to(@invitation.invited_to, :as => @invitation.role, :nickname => @invitation.nickname)
				UserMailer.send_invitation_for_child( @invitation ).deliver
				pop_flash "Invitation sent"			
		else
			pop_flash "Could not send invitation", :error, @invitee
		end
		
		redirect_to :back

	end
end

