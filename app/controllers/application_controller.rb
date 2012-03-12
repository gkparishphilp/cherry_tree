class ApplicationController < ActionController::Base
	
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
