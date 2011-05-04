class ObjectiveAssignmentsController < ApplicationController
	before_filter :get_child	
	
	def create
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@objective = @current_user.created_objectives.create( :name => params[:objective_assignment][:objective_name], 
							:description => params[:objective_assignment][:objective_description] )
		@objective.update_attributes( :creator_type => 'User', :objective_type => 'Misc' )
		@assignment = @current_user.created_assignments.new( params[:objective_assignment] )
		@assignment.objective = @objective
		@assignment.user = @child
		@assignment.period ||= 'day'
		if @assignment.save
			@current_user.do_activity "assigned '#{@assignment.objective.name}' to #{@child.display_name}", @assignment
			#redirect_to child_objective_assignments_path( @child )
			redirect_to :back
		else
			pop_flash "There was a problem with the assignment", :error, @assignment
			redirect_to :back
		end
	end
	
	def index
		if @current_user.is_child?
			@assignments = @current_user.objective_assignments.active
			render :child_index
		else
			unless @child.parents.include?( @current_user )
				pop_flash "Access Denied", :error
				redirect_to :back
				return false
			end	
			@assignments = @child.objective_assignments.available
			@new_assignment = ObjectiveAssignment.new
			@new_assignment.req_confirm = true
			
			@this_week = Time.now.end_of_week
			@last_week = @this_week - 7.days

			render :adult_index
		end
	end
	
	def show
		@assignment = ObjectiveAssignment.find( params[:id] )
	end
	
	def new
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@new_assignment = ObjectiveAssignment.new
		@new_assignment.req_confirm = true
	end
	
	def update
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@assignment = ObjectiveAssignment.find( params[:id] )
		@assignment.update_attributes( :status => params[:status] )
		redirect_to :back
	end
	

	
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	


end