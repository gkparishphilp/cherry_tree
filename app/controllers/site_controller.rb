class SiteController < ApplicationController
	caches_page :index
	
	def index
		# todo - implement site activities
		# @activities = Activity.feed Site.first
		@title = "Welcome"
		@articles = Article.published.order( 'publish_at asc' )
		render :layout => 'home'
	end
	
end