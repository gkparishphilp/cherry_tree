class InvitationsController < ApplicationController

	def create		
		@email = params[:email]
		@name = params[:name]
		@child = Child.find params[:child_id]
		@role = params[:role]
		@nickname = params[:nickname]
		
		# Create a user entry and relationship
		@user = User.find_or_initialize_by_email( :email => @email)
		@user.invitation_setup( @name, @nickname, @child, @role )

		# Send an email with the invitation
		UserMailer.send_invitation( @user, @child ).deliver

		pop_flash "Invitation sent to #{@email}"
		redirect_to :back

	end
end