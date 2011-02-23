class ObjectiveAssignmentsController < ApplicationController
	before_filter :get_child
	
	
	def create
		@assignment = @current_user.created_assignments.new( params[:objective_assignment] )
		@assignment.user = @child
		@assignment.period ||= 'week'
		if @assignment.save
			@current_user.do_activity "assigned '#{@assignment.objective.name}' to #{@child.display_name}", @assignment.objective
			pop_flash "Assignment Made"
		else
			pop_flash "There was a problem with the assignment", :error, @assignment
		end
		redirect_to child_objective_assignments_path( @child )
	end
	
	def index
		if @current_user.is_child?
			@assignments = @current_user.objective_assignments
			render :index_child
		else
			@assignments = @child.objective_assignments
			@new_assignemnt = @child.objective_assignments.new
			
			end_of_week = Time.now.end_of_week
			@last_four_weeks = []
			4.times do
				@last_four_weeks << end_of_week
				end_of_week -= 7.days
			end
				
			
			render :index_adult
		end
	end
	
	def new
		@assignment = ObjectiveAssignment.new
		@objectives = Objective.all
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end