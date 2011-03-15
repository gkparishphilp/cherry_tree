class ObjectiveAssignmentsController < ApplicationController
	before_filter :get_child
	
	
	def create
		@objective = @current_user.created_objectives.create( :name => params[:objective_assignment][:objective_name], 
							:description => params[:objective_assignment][:objective_description] )
		@objective.update_attributes( :creator_type => 'User', :objective_type => 'Misc' )
		@assignment = @current_user.created_assignments.new( params[:objective_assignment] )
		@assignment.objective = @objective
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
			@assignments = @current_user.objective_assignments.active
			render :index_child
		else
			@assignments = @child.objective_assignments.available
			@new_assignment = ObjectiveAssignment.new
			@new_assignment.req_confirm = true
			
			@this_week = Time.now.end_of_week
			@last_week = @this_week - 7.days

			render :index_adult
		end
	end
	
	def new
		@assignment = ObjectiveAssignment.new
		@assignment.req_confirm = true
		
		@objectives = Objective.all
	end

	def enable
		@assignment = ObjectiveAssignment.find params[:id]
		@assignment.update_attributes :status => 'active'
		redirect_to :back
	end
	
	def disable
		@assignment = ObjectiveAssignment.find params[:id]
		@assignment.update_attributes :status => 'inactive'
		redirect_to :back
	end
	
	def discard
		@assignment = ObjectiveAssignment.find params[:id]
		@assignment.update_attributes :status => 'deleted'
		redirect_to :back
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end

	
end