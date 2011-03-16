class UsersController < ApplicationController
	before_filter   :require_admin,   :only => [ :admin, :destroy ]
	before_filter	:require_login, :only => [ :home, :edit, :update ]

	
	def home
		if @current_user.is_child?
			redirect_to home_children_path
		else
			@activities = Activity.feed @current_user, @current_user.children, @current_user.supported_children
		end
		@invitation=Invitation.new
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
			pop_flash "This email address has already been registered.  Perhaps you've forgottne the password?", :notice
			redirect_to forgot_path
		else
			# this is a brand-new user, whether we found an email or not
			@user.attributes = params[:user]
		end
		
		@user.orig_ip = request.ip
		
		@user.status = 'pending'
	
		if @user.save
			
			@user.create_activation_code
			@user.reload
			
			#email = UserMailer.welcome( @user, @current_site ).deliver
			
			pop_flash "User successfully registered."
			
			login( @user )

			redirect_to children_path

		else
			pop_flash 'Ooops, User not saved.... ', :error, @user
			redirect_to register_path
		end

	end
	
	def collect_email
		@user = User.find_or_initialize_by_email params[:user][:email]
		@user.orig_ip = request.ip
		@user.status = 'email_collect'
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
		
		redirect_to request.env['HTTP_REFERER']
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

				email = UserMailer.forgot_password( @user, @current_site ).deliver
				pop_flash = "Email sent to #{user.email}.Please follow the enclosed instructions to recover your password.", :notice
				redirect_to root_path
			else
				params[:email] = nil
				pop_flash "No user with that email.", :error
			end
		end
	end
  
	def reset_password
		if session[:user_id].present?
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
		else
			pop_flash "No access without credential", :error
			redirect_to login_path
			return false
		end
		
		if ( params[:password] == params[:password_confirmation] && params[:password].present? )
			@user.password = params[:password]
			@user.remember_token = nil
			if @user.save
				pop_flash "Password updated"
				#just in case we're coming from forgot pw / email flow
				login( @user )
			else
				pop_flash "Invalid Password", :error, @user
			end
		else
			pop_flash "Passwords must match", :error
		end
		redirect_to :back

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









