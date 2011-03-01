class InvitationsController < ApplicationController
	
	def new
		@invitation = Invitation.new
	end
	
	def create	
		
		@invitation = Invitation.new params[:invitation]
		# Create a user entry and relationship
		if @invitee = User.find_or_initialize_by_email( :email => @invitation.email) and @invitation.setup( @current_user, @invitee)
				@invitee.relate_to(@invitation.invited_to, :as => @invitation.role, :nickname => @invitation.nickname)
				UserMailer.send_invitation_for_child( @invitation ).deliver
				@invitation.save
				pop_flash "Invitation sent"			
				
		else
			pop_flash "Could not send invitation", :error, @invitee
		end
		
		redirect_to :back
	end
	
	def accept_invite
		@invitation = Invitation.find_by_code params[:code]
		if @invitation.user.registered?
			redirect_to login_path( :credential => @invitation.user.email )
		else
			redirect_to register_path( :email => @invitation.user.email )
		end
		
	end
end

