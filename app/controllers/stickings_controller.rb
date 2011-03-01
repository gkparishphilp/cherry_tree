class StickingsController < ApplicationController
	
	def create
		@stickable = eval "#{params[:sticking][:stickable_type]}.find( #{params[:sticking][:stickable_id]} )"
		@sticker = Sticker.find( params[:sticking][:sticker_id] )
		@sticking = @stickable.stickings.create :sticker => @sticker
		pop_flash "Sticker Added"
		
		redirect_to :back
	end
	
	def update_pos
		@sticking = Sticking.find( params[:id] )
		top = params[:top] || @sticking.top
		left = params[:left] || @sticking.left
		
		sticking_attrs = { :top => top, :left => left }
		@sticking.update_attributes( sticking_attrs )
		redirect_to :back
	end
	
	def update_width
		@sticking = Sticking.find( params[:id] )
		width = params[:width] || @sticking.width
		
		@sticking.update_attributes( :width => width )
		redirect_to :back
	end
	
	def destroy
		@sticking = Sticking.find( params[:id] )
		@sticking.destroy
		pop_flash 'Sticker Removed'
		redirect_to :back
	end
	
	
end