class WishlistItemsController < ApplicationController
	
	def index
		@wishlist_items = @current_user.wishlist_items
	end

	def show
		@wishlist_item = WishlistItem.find( params[:id] )
	end
	
	def new
		@wishlist_item = WishlistItem.new
	end
	
	
	def create
		if @current_user.wishlists.empty?
			@current_user.wishlists.create :name => 'Default'
		end
		@wishlist_item = @current_user.wishlists.first.wishlist_items.new params[:wishlist_item]

		if @wishlist_item.save
			pop_flash "Item saved!"
		else
			pop_flash "Oooops, Item not saved", :error, @wishlist_item
		end		
		redirect_to :back
	end
	
	def destroy
		@wishlist_item = wishlist_item.find( params[:id] )
		@wishlist_item.destroy
		pop_flash "wishlist_item deleted."
		redirect_to :back
	end
	
	def search_amazon	
		@search_term = params[:search_term]
		@search_index = params[:search_index]
		@response = Amazon::Ecs.item_search( @search_term,  :response_group => "Medium", :search_index => @search_index )
	end
	

end
