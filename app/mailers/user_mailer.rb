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
	
	def earned_award( user, award)
		@child = user
		@award = award
		parents = @child.parents
		for @parent in parents
			mail :to => @parent.email, :from =>"noreply@thecherrytree.com", :subject =>" #{@child.name} has earned an award!"
		end
	end
	
	def send_contact( user, contact )
		@user = user
		@contact = contact
		mail :to => 'tay.x.nguyen@gmail.com', :from => "noreply@thecherrytree.com", :subject => "New contact"
	end
end
