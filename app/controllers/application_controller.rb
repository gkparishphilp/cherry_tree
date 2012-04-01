class ApplicationController < ActionController::Base
	protect_from_forgery
	helper	:all
	
	before_filter :fetch_session_data
	
	#after_filter	:check_for_achievements


protected


	# sets page metadata like page title and description
	def set_meta( title, *description )
		@title = title
		@description = description.first[0..200] unless description.first.blank?
	end

	def check_for_achievements
		return false if @current_user.nil? || @current_user.anonymous? || !@current_user.child?
		for achievement in Achievement.all
			if @current_user.newly_earned?( achievement )
				pop_flash "<br>Congratulations... You earned an Achievement: '#{achievement.name}'!"
				@current_user.do_activity( "Earn an Achievement: ", achievement)
			end
		end
	end

	def http_auth
		authenticate_or_request_with_http_basic do |name, pass|
			name == 'admin' && pass == 'gr0undsw3ll'
		end
	end

	# Custom 404s & 500 catch-all
	if Rails.env.production?
		rescue_from ActionController::UnknownAction, :with => :invalid_method
		rescue_from ActionController::RoutingError, :with => :invalid_method
		rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
		rescue_from Exception, :with => :server_error
	end
	
	# Grabs @current_user from session cookie, also sets human attribute 
	# and @current_site, which in this case is always just the first (and only) site object
	def fetch_session_data
		@current_user = ( session[:user_id] && User.find( session[:user_id] ) ) || User.anonymous
		@current_user.human = @current_user.logged_in? || cookies[:human] == 'true'
		@current_site = Site.first
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
			flash[code] = "#{message}"
		else
			flash[code] += "#{message}"
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
			pop_flash "Please log in first", :notice
			redirect_to new_session_path
			return false
		else
			unless @current_user.admin?( @current_site )
				pop_flash "Admins Only", :notice
				redirect_to root_path
				return false
			end
		end
	end
	
	def require_admin_or_contributor
		if @current_user.anonymous?
			pop_flash "Please log in first", :notice
			redirect_to new_session_path
			return false
		else
			unless @current_user.admin?( @current_site ) || @current_user.contributor?( @current_site )
				pop_flash "Admins or Contributors Only", :notice
				redirect_to root_path
				return false
			end
		end
	end

	def require_login
		if @current_user.anonymous?
			pop_flash  "Please log in first", :notice
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
		unless ( object.user == @current_user ) || @current_user.admin?( @current_site ) 
			pop_flash "Not your #{object.class.to_s}", :error
			redirect_to root_path
			return false
		end
	end
	
	########### FAIL PAGES   ##################
	def record_not_found( exception )
		render 'errors/not_found', :layout => 'error', :status => :not_found
	end

	def invalid_method( exception )
		render 'errors/not_found', :layout => 'error', :status => :method_not_allowed
	end
	
	def server_error( exception )
		@crash = Crash.create :message => exception.to_s, :requested_url => request.url, 
						:referrer => request.env['HTTP_REFERER'], :backtrace => exception.backtrace.join("\n")
		render 'errors/server_error', :layout => 'error', :status => 500
	end
	
	
	
end
