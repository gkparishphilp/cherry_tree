class EmailValidator < ActiveModel::EachValidator
	require 'resolv'
	# temporary.... check email format with crufty regex, then try to look up MX records
	# use this when it's baked: http://github.com/heycarsten/email-veracity/tree/master/lib/email_veracity/

	def validate_each(record, attribute, value)
		unless  value =~ /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i
			record.errors[attribute] << (options[:message] || "is not a valid address") 
		else
			record.errors[attribute] << (options[:message] || "domain name appears to be incorrect") unless validate_domain( value )
		end
	end
	
	def validate_domain( email )
		domain = email.match(/\@(.+)/)[1]
		Resolv::DNS.open do |dns|
			@mx = dns.getresources( domain, Resolv::DNS::Resource::IN::MX )
		end
		@mx.size > 0 ? true : false
	end
  
end