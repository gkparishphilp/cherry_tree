class SessionsController < ApplicationController
	def new
		@title = 'Login'
	end
  
	def create
		
		user, msg = User.authenticate( params[:credential], params[:password] )

		if user
			login( user )
			pop_flash msg
			redirect_to home_path
		elsif user == false
			pop_flash msg, :error
			redirect_to register_path( :email => params[:email] )
		else
			params[:password] = nil
			pop_flash msg, :error
			redirect_to new_session_path
		end
	end
	
	def register
		@user = User.new
		@user.email = params[:email]
	end
	
	def register_invitee
		@user = User.find( params[:id] )
		@invite_code = params[:invite_code]
	end
	
	def destroy
		if @current_user
			user = User.find_by_id @current_user.id
			logout( user )
			pop_flash "#{user.name} logged out"
			redirect_to root_path
		else
			flash[:notice] = "No one logged in"
			redirect_to login_path
		end
	end

	def pending
		if @current_user.anonymous?
			@user = User.find params[:user_id]
		else
			@user = @current_user
		end
	end
  
	def go_twitter
		send_twitter_request( 'user' )
	end
	
	def go_site_twitter
		send_twitter_request( 'site' )
	end

	def ret_twitter
		process_twitter_response( 'user' )
	end
	
	def ret_site_twitter
		process_twitter_response( 'site' )
	end
	
	def go_facebook
		redirect_to facebook_oauth_url( ret_facebook_sessions_url )
	end
	
	def go_site_facebook
		redirect_to facebook_oauth_url( ret_site_facebook_sessions_url )
	end
	
	def ret_facebook
		process_facebook_response( 'user')
	end
	
	def ret_site_facebook
		process_facebook_response( 'site' )
	end
	

private

	def twitter_oauth
		@oauth ||= Twitter::OAuth.new( TWITTER_KEY, TWITTER_SECRET, :sign_in => true )
	end
	
	def facebook_oauth_url( callback_url )
		scopes = ["offline_access", "user_about_me", "user_status", "publish_stream", "read_stream", "manage_pages"]
		@oauth_url = MiniFB.oauth_url( FB_APP_ID, callback_url, :scope => scopes.join(",") )
	end
	
	def send_twitter_request( type )
		case type
			when 'site'
				twitter_oauth.set_callback_url( ret_site_twitter_sessions_url )
			when 'user'
				twitter_oauth.set_callback_url( ret_twitter_sessions_url )
		end
			
			session['rtoken'] = twitter_oauth.request_token.token
			session['rsecret'] = twitter_oauth.request_token.secret

			redirect_to twitter_oauth.request_token.authorize_url
	end
	
	def process_twitter_response( type )
			
		twitter_oauth.authorize_from_request( session['rtoken'], session['rsecret'], params[:oauth_verifier] )
		session['rtoken'] = nil
		session['rsecret'] = nil

		unless @profile = Twitter::Base.new( twitter_oauth ).verify_credentials
			pop_flash "Oooops, something went wrong with Twitter association", :error
		end

		token = twitter_oauth.access_token.token
		secret = twitter_oauth.access_token.secret
		
		case type
			when 'user'
				if twit_account = TwitterAccount.find_by_twit_id_and_owner_type( @profile.id, 'User' )
					twit_account.update_attributes( :token => token, :secret => secret, :twit_id => @profile.id, 
													:name => @profile.screen_name )
					pop_flash "Twitter Login Successful"
					login( twit_account.owner )
					redirect_to @current_user
				elsif @current_user.logged_in?
					@current_user.twitter_accounts.create( :token => token, :secret => secret, :twit_id => @profile.id, 
													:name => @profile.screen_name )
					pop_flash "Twitter Account added"
					redirect_to @current_user #todo user_settings_path
				else
					pop_flash "No Account found for user", :error
					redirect_to root_path
				end
			when 'site'
				if twit_account = @current_site.twitter_accounts.find_by_twit_id( @profile.id )
					twit_account.update_attributes( :token => token, :secret => secret, :twit_id => @profile.id, 
													:name => @profile.screen_name )
					pop_flash "That account is already associated with the site", :notice
				else
					@current_site.twitter_accounts.create( :token => token, :secret => secret, :twit_id => @profile.id, 
													:name => @profile.screen_name )
					pop_flash "Twitter account added"
				end
				redirect_to admin_site_index_path
		end
	end
	
	
	def process_facebook_response( type )
		# We have to reconstruct the url we used to call facebook
		case type
			when 'user'
				auth_url = facebook_oauth_url( ret_facebook_sessions_url )
			when 'site'
				auth_url = facebook_oauth_url( ret_site_facebook_sessions_url )
		end
		code = params['code'] # Facebooks verification string
		access_token_hash = MiniFB.oauth_access_token( FB_APP_ID, auth_url, FB_APP_SECRET, code )
		@facebook_access_token = access_token_hash["access_token"]
	      
		@facebook_user = MiniFB.get( @facebook_access_token, "me", :metadata => true )
		
		case type
			when 'user'
				if fb_account = FacebookAccount.find_by_fb_id_and_owner_type( @facebook_user.id, 'User' )
					fb_account.update_attributes( :fb_token => @facebook_access_token )
					get_facebook_pages_for( fb_account )
					pop_flash "Facebook Login successful"
					login( fb_account.owner )
					redirect_to @current_user
				elsif @current_user.logged_in?
					fb_account = @current_user.facebook_accounts.create( :name => @facebook_user.name, 
									:fb_id => @facebook_user.id, :fb_token => @facebook_access_token )
					get_facebook_pages_for( fb_account )
					pop_flash "Facebook Account added"
					redirect_to @current_user #todo user_settings_path
				else
					pop_flash "No Account found for user", :error
					redirect_to root_path
				end
			when 'site'
				if fb_account = @current_site.facebook_accounts.find_by_fb_id( @facebook_user.id )
					fb_account.update_attributes( :fb_token => @facebook_access_token )
					get_facebook_pages_for( fb_account )
					pop_flash "That account is already associated with the site", :notice
				else
					fb_account = @current_site.facebook_accounts.create( :name => @facebook_user.name, 
							:fb_id => @facebook_user.id, :fb_token => @facebook_access_token )
					get_facebook_pages_for( fb_account )
					pop_flash "Facebook Account added"
				end
				redirect_to admin_site_index_path
		end
		
	end
	
	def get_facebook_pages_for( fb_account )
		query = "SELECT page_id FROM page_admin WHERE uid=#{@facebook_user.id}"
		@page_ids = MiniFB.fql( @facebook_access_token, query ).collect { |page_hash| page_hash["page_id"] }

		@page_ids.each do |page_id|
			res = MiniFB.get( @facebook_access_token, page_id, :metadata => true )
			p = fb_account.facebook_pages.find_by_fb_id( res.id ) || 
				fb_account.facebook_pages.create( :fb_id => res.id, :name => res.name, :page_type => 'page' )
		end
	
		# Lets try groups
		@res = MiniFB.get( @facebook_access_token, "me", :type => 'groups' )
		for group in @res.data
			next unless group.administrator == 'true'
			g = fb_account.facebook_pages.find_by_fb_id( group.id ) ||
				fb_account.facebook_pages.create( :fb_id => group.id, :name => group.name, :page_type => 'group' )
		end
	end
	

end
