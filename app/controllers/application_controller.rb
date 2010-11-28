class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :fetch_logged_in_user


protected
	# Grabs @current_user from session cookie
	def fetch_logged_in_user
		@current_user = ( session[:user_id] && User.find( session[:user_id] ) ) || User.anonymous
		@current_user.human = @current_user.logged_in? || cookies[:human] == 'true'
	end
	
	# simply sets session cookie for passed-in user
	def login( user )
		@current_user = user
		session[:user_id] = user.id
		user.update_attributes :last_ip => request.ip
	end
	
	#simply clears the session cookie
	def logout( user )
		@current_user = session[:user_id] = nil
		cookies[:human] = nil
	end
	
	# populates the flash with message and error messages if any
	def pop_flash( message, code = :success, *object )
		if flash[code].blank?
			flash[code] = "<b>#{message}</b>"
		else
			flash[code] += "<b>#{message}</b>"
		end
		
		object.each do |obj|
			obj.errors.each do |field, msg|
				flash[code] += "<br>" + field.to_s + ": " if field
				flash[code] += " " + msg 
			end
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
	
	
	# Controller filters -- todo -- add @current_user.validated? for filter on valid email
	def require_admin
		if @current_user.anonymous?
			flash[:notice] = "Please log in first"
			redirect_to new_session_path
			return false
		else
			unless @current_user.is_admin?
				flash[:notice] = "Admins Only"
				redirect_to root_path
				return false
			end
		end
	end
	
	def require_contributor
		if @current_user.anonymous?
			flash[:notice] = "Please log in first"
			redirect_to new_session_path
			return false
		else
			unless @current_user.contributor? @current_site
				flash[:notice] = "Contributors Only"
				redirect_to root_path
				return false
			end
		end
	end

	def require_login
		if @current_user.anonymous?
			pop_flash  "Please log in first", :notice
			@dest = request.url
			redirect_to new_session_path
			return false
		end
	end
	
	def require_validated
		unless @current_user.validated?
			pop_flash "Must have validated email", :notice
			redirect_to root_path
			return false
		end
	end
	
	
	def require_user_can_manage( object )
		unless ( object.user == @current_user ) || ( @current_site.admins.include? @current_user )
			pop_flash "Not your #{object.class.to_s}", :error
			redirect_to root_path
			return false
		end
	end
	
	def require_author_can_manage( object )
		#todo
	end
	
	# sets page metadata like page title and description
	def set_meta( title, *description )
		@title = title
		@description = description.first[0..200] unless description.first.blank?
	end
	
	
end
