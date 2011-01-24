class SiteController < ApplicationController
	before_filter	:require_admin, :except => :index
	
	def index
		# todo - implement site activities
		# @activities = Activity.feed Site.first
		
		@articles = Article.published.order( 'publish_at asc' )
		
	end
	
end