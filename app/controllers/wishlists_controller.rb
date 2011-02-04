class WishlistsController < ApplicationController

	def admin
		@wishlists = Wishlist.all
	end
	
	def index
		@wishlists = Wishlist.all
	end

	def show
		@wishlist = Wishlist.find( params[:id] )
	end
	
	def new
		@wishlist = Wishlist.new
	end
	
	def edit
		@wishlist = Wishlist.find( params[:id] )
	end
	
	def create
		@wishlist = Wishlist.new( params[:wishlist] )

		if @wishlist.save
			pop_flash "Wishlist was successfully created."
		else
        	pop_flash "Wishlist could not be created.", :error, @wishlist
		end
		redirect_to :back
	end

	def update
		@wishlist = Wishlist.find( params[:id] )

		if @wishlist.update_attributes( params[:wishlist] )
			pop_flash "Wishlist was successfully updated."
		else
			pop_flash "Wishlist could not be updated.", :error, @wishlist
		end
		redirect_to :back
	end

	def destroy
		@wishlist = Wishlist.find( params[:id] )
		@wishlist.destroy
		pop_flash "Wishlist deleted."
		redirect_to :back
	end

end
