class MerchesController < ApplicationController

	def admin
		@merches = Merch.all
	end
	
	def index
		@merches = Merch.all
	end

	def show
		@merch = Merch.find( params[:id] )
	end
	
	def new
		@merch = Merch.new
	end
	
	def edit
		@merch = Merch.find( params[:id] )
	end
	
	def create
		@merch = Merch.new( params[:merch] )

		if @merch.save
			pop_flash "Merch was successfully created."
		else
        	pop_flash "Merch could not be created.", :error, @merch
		end
		redirect_to :back
	end

	def update
		@merch = Merch.find( params[:id] )

		if @merch.update_attributes( params[:merch] )
			pop_flash "Merch was successfully updated."
		else
			pop_flash "Merch could not be updated.", :error, @merch
		end
		redirect_to :back
	end

	def destroy
		@merch = Merch.find( params[:id] )
		@merch.destroy
		pop_flash "Merch deleted."
		redirect_to :back
	end

end
