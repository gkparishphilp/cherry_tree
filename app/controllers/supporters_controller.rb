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
	
	def disable
		@supporter = User.find( params[:supporter_id])
		@supporter.unrelate_to( @child )
		redirect_to :back
	end	
	
	def enable
		@supporter = User.find( params[:supporter_id])
		@supporter.rerelate_to( @child )
		redirect_to :back
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	

end