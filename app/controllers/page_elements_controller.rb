class PageElementsController < ApplicationController
	
	def create
		@page = eval "#{params[:page_element][:page_type]}.find( #{params[:page_element][:page_id]} )"
		@sticker = Sticker.find( params[:page_element][:sticker_id] )
		@sticking = @page.page_elements.create :sticker => @sticker
		pop_flash "Sticker Added"
		
		redirect_to :back
	end
	
	def updater
		obj = eval "#{params[:obj_type].capitalize}.find( #{params[:obj_id]} )"
		attrs = {}
		for key in params.keys do
			attrs[key] = params[key] if obj.respond_to?( key ) && params[key].present?
		end
		
		obj.update_attributes( attrs )
		
		redirect_to :back
	end
	
	
	def destroy
		@sticking = Sticking.find( params[:id] )
		@sticking.destroy
		pop_flash 'Sticker Removed'
		redirect_to :back
	end
	
	
end