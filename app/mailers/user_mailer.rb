class UserMailer < ActionMailer::Base
	
	def send_invitation( user, child )
		@user = user
		@child = child
		mail :to => "#{user.name} <#{user.email}>", :from => "noreply@thecherrytree.com", :subject => "#{child.name} has invited you to their Cherry Tree website."
	end
	

end
