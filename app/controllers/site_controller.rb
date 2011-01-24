class SiteController < ApplicationController
	before_filter	:require_admin, :except => :index
	
	def index
		# todo - implement site activities
		# @activities = Activity.feed Site.first
	end
	
end