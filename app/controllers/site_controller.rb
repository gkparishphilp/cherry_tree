class SiteController < ApplicationController
	before_filter	:require_admin, :except => :index
	caches_page :index
	
	def index
		# todo - implement site activities
		# @activities = Activity.feed Site.first
		@title = "Welcome"
		@articles = Article.published.order( 'publish_at asc' )
		
	end
	
end