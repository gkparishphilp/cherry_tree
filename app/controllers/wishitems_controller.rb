class WishitemsController < ApplicationController
	before_filter	:get_child

	def admin
		@wishitems = Wishitem.all
	end
	
	def index
		@wishitems = @child.wishitems
	end

	def show
		@wishitem = Wishitem.find( params[:id] )
	end
	
	def new
		@wishitem = Wishitem.new
	end
	
	def edit
		@wishitem = Wishitem.find( params[:id] )
	end
	
	def create
		if asin = params[:wishitem][:asin]
			search_index = params[:wishitem][:search_index]
			@award = Wishitem.create_from_amazon( asin, search_index )
			redirect_to edit_wishitem_path( @wishitem )
			return false
		else
			@wishitem = Wishitem.new params[:wishitem]
		end
		
		@wishitem.child = @child
		
		if @wishitem.save
			process_attachments_for( @wishitem )
			pop_flash "Wishlist item Created"
		else
			pop_flash "Oooops, Wishlist item not saved", :error, @award
		end
		redirect_to :back
	end
	
	def update
		@wishitem = Wishitem.find( params[:id] )

		if @wishitem.update_attributes( params[:wishitem] )
			pop_flash "Wishitem was successfully updated."
		else
			pop_flash "Wishitem could not be updated.", :error, @wishitem
		end
		redirect_to :back
	end

	def destroy
		@wishitem = Wishitem.find( params[:id] )
		@wishitem.destroy
		pop_flash "Wishitem deleted."
		redirect_to :back
	end
	
	def search_amazon	
		@search_term = params[:search_term]
		@search_index = params[:search_index]
		@response = Amazon::Ecs.item_search( @search_term,  :response_group => "Medium", :search_index => @search_index )
	end
	
	private
	
	def get_child
		@child = @current_user
	end

end
