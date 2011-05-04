class SupportersController < ApplicationController
	before_filter	:get_child
	
	def index
		if @current_user.is_child?
			render :child_index
		else
			unless @child.parents.include?( @current_user )
				pop_flash "Access Denied", :error
				redirect_to :back
				return false
			end
			@supporters = @child.related_users
			render :adult_index
		end
	end
	
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end