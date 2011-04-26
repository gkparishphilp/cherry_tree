class SupportersController < ApplicationController
	before_filter	:get_child
	
	def index
		if @current_user.is_child?
			render :child_index
		else
			if get_parental_permission( @child )
				@supporters = @child.related_users
				render :adult_index
			else
				pop_flash "Sorry, access denied", :error
				redirect_to :root
			end
		end
	end
	
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end