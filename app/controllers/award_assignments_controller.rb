class AwardAssignmentsController < ApplicationController
	before_filter :get_child
	
	
	def create
		
		if params[:amazon]
			redirect_to amazon_path( :search_term => params[:award_assignment][:award_name] )
			return false
		end
		
		@award = @current_user.created_awards.create( :name => params[:award_assignment][:award_name], 
									:description => params[:award_assignment][:award_description])
		@award.update_attributes( :creator_type => 'User' )
		@assignment = @current_user.created_award_assignments.new( params[:award_assignment] )
		@assignment.award = @award
		@assignment.user = @child
		if @assignment.save
			pop_flash "Assignment Made"
			if params[:first]
				redirect_to new_child_award_assignment_path( @child )
			else
				redirect_to child_award_assignments_path( @child )
			end
		else
			pop_flash "There was a problem with the assignment", :error, @assignment
			redirect_to :back
		end
		
	end
	
	def index
		@assignments = @child.award_assignments
		@awards = @current_user.created_awards.map{ |award| 
			[ "#{award.name} - #{award.award_type} (#{award.point_cost})", award.id ]
			}
		
		@new_assignment = @child.award_assignments.new
	end
	
	def new
		@assignment = AwardAssignment.new
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end