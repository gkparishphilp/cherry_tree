class SupportersController < ApplicationController
	before_filter	:get_child
	
	def index
		if @current_user.is_child?
			render :child_index
		else
			@supporters = @child.related_users
			render :adult_index
		end
	end
	
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end