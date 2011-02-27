class StickingsController < ApplicationController
	
	def create
		
	end
	
	def stick
		@sticking = Sticking.find( params[:id] )
		top = params[:top] || @sticking.top
		left = params[:left] || @sticking.left
		width = params[:width] || @sticking.width
		
		sticking_attrs = { :top => top, :left => left, :width => width }
		@sticking.update_attributes( sticking_attrs )
		redirect_to :back
	end
	
	
end