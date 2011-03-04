class InvitationsController < ApplicationController

	def create		
		@email = params[:email]
		@name = params[:name]
		@child = Child.find params[:child_id]
		@role = params[:role]
		@nickname = params[:nickname]
		
		# Create a user entry and relationship
		if @user = User.find_or_initialize_by_email( :email => @email)
			@user.invitation_setup( @name, @nickname, @child, @role )
			UserMailer.send_invitation( @user, @child ).deliver
			pop_flash "Invitation sent to #{@email}"
		else 
			pop_flash "Could not send invitation", :error, @user
		end
		
		redirect_to :back

	end
	
	def index
		@children = @current_user.children.map {|child| [child.name, child.id]}
	end
	
	
end