class SiteController < ApplicationController
	before_filter	:require_admin, :except => :index
	
	def index
		@activities = Activity.feed Site.first
	end
	
end