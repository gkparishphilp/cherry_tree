class ResourcesController < ApplicationController
	
	def index
	end
	
	def show
		@resource = Resource.find params[:id]
		render :layout => 'application'
	end
end