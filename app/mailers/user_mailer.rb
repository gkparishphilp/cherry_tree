class UserMailer < ActionMailer::Base
	
	def send_invitation_for_child( invitation )
		@invitation = invitation
		@invitee = invitation.user
		@child = invitation.child
		mail :to => invitation.user.email, :from => "noreply@thecherrytree.com", :subject => "#{@child.name} has invited you to their Cherry Tree website."
	end
	
	# #{@invitee.name} <#{@invitee.email}>
	
	def send_welcome_email( user, site )
		@user = user
		@current_site = site
		mail :to => user.email, :from => "noreply@thecherrytree.com", :subject => "Welcome to CherryTree!"
	end
	
	def forgot_password( user, site )
		@user = user
		@current_site = site
		mail :to => user.email, :from => "noreply@thecherrytree.com", :subject => "Forgotten Password"
	end
end
