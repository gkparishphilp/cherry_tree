class AdminController < ApplicationController

	# make sure @current_user is an admin or contributor
	before_filter :require_admin_or_contributor
	
end