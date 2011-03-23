class UserMailer < ActionMailer::Base
	
	def send_invitation_for_child( invitation )
		@invitation = invitation
		@invitee = invitation.user
		@child = invitation.child
		mail :to => "tay3@backmybook.com", :from => "noreply@thecherrytree.com", :subject => "#{@child.name} has invited you to their Cherry Tree website."
	end
	
	# #{@invitee.name} <#{@invitee.email}>
end
