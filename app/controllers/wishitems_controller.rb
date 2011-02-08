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
		@wishitem = Wishitem.new params[:wishitem]
		@award = Award.new
		@award.name = params[:wishitem][:name]
		@award.description = params[:wishitem][:description]
		@award.child_id = @child.id
		if @award.save
			Wishitem.create :child_id => @child.id, :award_id => @award.id
			pop_flash "Wishlist item saved!"
		else
			pop_flash "Oooops, Wishlist item not saved", :error
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
