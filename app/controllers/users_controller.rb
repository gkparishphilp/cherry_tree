class UsersController < ApplicationController
	before_filter   :require_admin,   :only => [ :admin, :destroy ]

	def admin
		@users = User.all.paginate :page => params[:page], :per_page => 25
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
			@activities = Activity.feed @user, @user.children
			render :private
		else 
			# Let's just show the public profile
			set_meta @user.name, @user.bio
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
		@user = User.find_or_initialize_by_email params[:user][:email]
		if @user.hashed_password.present?
			# someone created an account with this email address before.... send to forgot pass?
		else
			# this is a brand-new user, whether we found an email or not
			@user.attributes = params[:user]
		end
		
		@user.orig_ip = request.ip
		dest = params[:dest]
		
		@user.status = 'pending'
	
		if @user.save
			
			@user.create_activation_code
			@user.reload
			
			#email = UserMailer.welcome( @user, @current_site ).deliver
			@user.did_join Site.first
			
			pop_flash "User successfully registered."
			
			login( @user )

			redirect_to @user

		else
			pop_flash 'Ooops, User not saved.... ', :error, @user
			@dest = dest
			redirect_to register_path
		end

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









