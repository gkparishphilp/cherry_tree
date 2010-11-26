def create
	@book = Book.new params[:book]
	if @book.save
		process_attachments_for( @book )
	else
		pop_flash "There was a problem with the book:", :notice, @book
	end
	
	if flash[:notice].blank?
		redirect_to @book
	else
		render :new
	end

end

def process_attachments_for( obj )
	# the idea is to scan the params has for any fields with names matching "attached_whatever_something"
	# like "attached_avatar_file", or "attached_photos_url" -- this method will take the value be it a file
	# upload resource or a url and either update the attachment (if the attachment is a singular resource and
	# the owning object has one already) or create a new one (otherise).  So, attachemnt collections are always added to
	for key in params.keys do
		if key =~ /attached_(.+)_/
			next if params[key].blank?
			resource = params[key]
			if ( eval "obj.#{$1}" ) && !( eval "obj.#{$1}.respond_to? 'each'" )
				# the object has an attachemnt of that type in the attachemnts_table and the 
				# attachment is a singular (e.g. doesn't respond to .each ) so let's update
				attach = eval "obj.#{$1}.update_from_resource( resource )"
			else
				attach = Attachment.create_from_resource( resource, $1, :owner => obj )
			end
			pop_flash "There was a problem with the #{attach.name} Attachment", :error, attach unless attach.errors.empty?
		end
	end
end

# populates the flash with message and error messages if any
def pop_flash( message, code = :success, *object )
	if flash[code].nil?
		flash[code] = "<b>#{message}</b>"
	else
		flash[code] += "<br><b>#{message}</b>"
	end
	object.each do |obj|
		obj.errors.each do |field, msg|
			flash[code] += "<br>" + field.to_s + ": " if field
			flash[code] += " " + msg 
		end
	end
end