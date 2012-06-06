class UsersController < ApplicationController
	before_filter   :require_admin,   :only => [ :admin, :destroy ]
	before_filter	:require_login, :only => [ :home, :edit, :update ]	
	
	def home
		if @current_user.is_child?
			@child = Child.find @current_user.id
			@screen_item = @current_user.best_item
			@activities = Activity.feed( @current_user )
			@relevant_assignment, @relevant_assignment_parent, @num_assignments = @current_user.most_relevant
			@lesson_assignments= @child.lesson_assignments
			
			@active_assignments = @current_user.objective_assignments.active - @current_user.objective_assignments.map{ |assignment| assignment if assignment.checkin_in_last?(Time.now.beginning_of_day)}
			@checked_in_assignments = @current_user.objective_assignments.checked_in
			if @relevant_assignment_parent.is_a?( Lesson )
				@viewing = LessonViewing.find_or_initialize_by_user_id_and_lesson_id( @current_user.id, @relevant_assignment_parent.id )
				@viewing.update_attributes :updated_at => Time.now
			end
		
			render 'child/home'
		else
			if @current_user.children.empty? && @current_user.supported_children.empty?
				redirect_to new_child_path
			else
				@activities = Activity.feed( @current_user, @current_user.children, @current_user.supported_children )
				render 'adult/home'
			end
		end
	end
	
	def show
		@user = User.find( params[:id] )
		if @user.anonymous? 
			flash[:notice] = "Invalid User"
			redirect_to root_path
			return false
		end
		# first things first, public or private?
		if @user == @current_user
			redirect_to home_path
		else 
			# Let's just show the public profile
			render	:public
		end
	end

	def new
		@user = User.new
		@dest = params[:dest]
		@a = params[:a]
	end

	def edit
		@user = User.find params[:id] 
		if @current_user.anonymous?
			flash[:notice] = "Can't edit this user"
			redirect_to root_path
			return false
		end

		if @user != @current_user || !@current_user.admin?
			flash[:notice] = "Can't edit this user"
			redirect_to root_path
			return false
		end
    
		@roles = Role.all
	end

	def create
		@user = User.find_or_initialize_by_email( params[:user][:email] )
		if @user.hashed_password.present?
			# someone created an account with this email address before.... send to forgot pass?
			pop_flash "This email address has already been registered.  Perhaps you've forgotten the password?", :notice
			redirect_to forgot_path
			return
		else
			# this is a brand-new user, whether we found an email or not
			@user.attributes = params[:user]
		end
		
		@user.orig_ip = request.ip
		
		@user.display_name = params[:fname] + " " + params[:lname]
		@user.first_name = params[:fname]
	
		@user.newsletter_opt_in = true if params[:subscribe_to_newsletter]
	
		if @user.save
			
			@user.create_activation_code
			@user.reload
			
			email = UserMailer.send_welcome_email( @user, @current_site ).deliver
			
			login( @user )

			redirect_to home_path

		else
			pop_flash 'Ooops, User not saved.... ', :error, @user
			redirect_to register_path
		end

	end
	
	def check_name
		clean_name = params[:name].gsub( /\W+/, '_' )
		if User.find_by_name( clean_name )
			@available = false
			@result =  "#{params[:name]} has been taken."
		else
			@available = true
			@result = "#{params[:name]} is available."
		end
	end
	
	def collect_email
		@user = User.find_or_initialize_by_email params[:user][:email]
		@user.orig_ip = request.ip
		@user.newsletter_opt_in = true
		if @user.save
			pop_flash "Thank You for Signing Up!"
		else
			pop_flash "There was a problem with your submission", :error, @user
		end
		redirect_to :back
	end

	def update
		@user = User.find params[:id] 
	
		if @user.update_attributes( params[:user] )
			process_attachments_for( @user )
			pop_flash 'User was successfully updated.'	
		else
			pop_flash 'Oooops, User not updated...', 'error', @user
		end
		
		redirect_to :back
	end

	def destroy
		@user = User.find params[:id]
		@user.destroy
	end
  
	def forgot_password
		if request.post?
			user = User.find_by_email(params[:email])
			if user
				user.create_remember_token
				user.reload

				email = UserMailer.forgot_password( user, @current_site ).deliver
				pop_flash = "Email sent to #{user.email}.Please follow the enclosed instructions to recover your password.", :error
				redirect_to new_session_path
			else
				params[:email] = nil
				pop_flash "No user with that email.", :error
			end
		end
	end
  
	def reset_password
		# Check to see if this is changing the password for a child first, and then go on to changing a user's password
		if params[:child_id].present?
			@user = User.find params[:child_id]
		elsif session[:user_id].present?
			# a user is logged in, 
			@user = User.find session[:user_id]
		elsif params[:token]
			valid_token_user = User.find_by_remember_token params[:token]  #can add date expiry later
			unless valid_token_user
				pop_flash "Invalid password reset token", :error
				redirect_to login_path
				return false
			end
			@user = valid_token_user
		elsif params[:invite_code]
			invitation = Invitation.find_by_code params[:invite_code]
			@user = invitation.user
		else
			pop_flash "No access without credential", :error
			redirect_to login_path
			return false
		end
		
		if request.post?
			if ( params[:password] == params[:password_confirmation] && params[:password].present? )
				@user.password = params[:password]
				@user.remember_token = nil
				if @user.save
					pop_flash "Password updated"
					#just in case we're coming from forgot pw / email flow but don't login if we're resetting a child's password
					login( @user ) unless params[:child_id]
					redirect_to home_path
				else
					pop_flash "Invalid Password", :error, @user
				end
			else
				pop_flash "Passwords must match", :error
			end
		end
	end

	def activate
		activ_code = params[:token] || "none"
		valid_user = User.find_by_activation_code( activ_code )

		if !valid_user
			pop_flash "Invalid activation code", :error
			redirect_to root_path
			return false
		else
			pop_flash "Your account has been activated"
			valid_user.update_attributes :status => 'first', :activated_at => Time.now
		
			login( valid_user )
			
			redirect_to valid_user
		end
	end
	
	def resend
		@user = User.find params[:id]
		email_args = { :user => @user }
		email = UserMailer.welcome( @user, @current_site ).deliver
		flash[:notice] = "An Email has been sent to #{@user.email}.  Please follow the enclosed instructions to fully activate your account."
		
		redirect_to pending_sessions_path( :user_id => @user.id )
	end
		
end









