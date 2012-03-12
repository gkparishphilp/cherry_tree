
class Child < User

	after_create	:setup_defaults


	 							
	# for the child/create form -- may just switch to form_tag at some point....
	attr_accessor :role, :nick, :welcome_message


end
