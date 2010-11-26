class SiteController < ApplicationController
	before_filter	:require_admin, :except => :index
	
	def index
		
	end
	
end