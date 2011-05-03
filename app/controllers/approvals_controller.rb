class ApprovalsController < ApplicationController
	before_filter :get_child
	
	def index
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@checkins = @child.checkins.unapproved 
	end
	
	def create
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@approval = Approval.new params[:approval]
		@approval.creator = @current_user

		if @approval.save
			pop_flash "Approval saved!"
			@approval.objective_assignment.user.earn_points_for( @approval.objective_assignment, @approval.objective_assignment.point_value )
		else
			pop_flash "Error"
		end
		redirect_to :back
	end

	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end