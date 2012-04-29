class ResourcesController < ApplicationController
	
	def index
	end
	
	def show
		@resource = Resource.find params[:id]
	end
end