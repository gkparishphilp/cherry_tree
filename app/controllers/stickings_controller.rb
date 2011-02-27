class StickingsController < ApplicationController
	
	def create
		
	end
	
	def stick
		@sticking = Sticking.find( params[:id] )
		@sticking.update_attributes :top => params[:top], :left => params[:left]
		redirect_to :back
	end
	
	
end