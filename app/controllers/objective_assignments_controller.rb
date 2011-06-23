class ObjectiveAssignmentsController < ApplicationController
	before_filter :get_child	
	
	
	def activate
		@objective = Objective.find( params[:objective_id] )
		if @assignment = @objective.assignment_for( @child )
			@assignment.update_attributes :status => 'active'
		else
			# create assignment
			@assignment = @current_user.created_objective_assignments.create :objective => @objective, :user => @child, :status => 'active', :creator => @current_user, :point_value => @objective.point_value, :description => @objective.description
		end
		redirect_to child_objective_assignments_path( @child )
	end
	
	def deactivate
		@assignment = ObjectiveAssignment.find( params[:assignment_id] )
		@assignment.update_attributes :status => 'inactive'
		redirect_to child_objective_assignments_path( @child )
	end
	
	def create
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@objective = @current_user.created_objectives.create( :name => params[:objective_assignment][:objective_name], 
							:description => params[:objective_assignment][:objective_description], :point_value => params[:objective_assignment][:point_value] )
		@objective.update_attributes( :creator_type => 'User', :objective_type => 'Misc' )
		@assignment = @current_user.created_objective_assignments.new( params[:objective_assignment] )
		@assignment.objective = @objective
		@assignment.user = @child
		@assignment.period ||= 'day'
		if @assignment.save
			@current_user.do_activity "assigned '#{@assignment.objective.name}' to #{@child.display_name}", @assignment
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
			@assignments = @child.objective_assignments.active
			@new_assignment = ObjectiveAssignment.new
			@new_assignment.req_confirm = true
			
			
			@custom_objectives = @current_user.created_objectives - @child.active_assigned_objectives
			
			@academic_objectives = Site.first.created_objectives.where( :category => 'academics' ) - @child.active_assigned_objectives
			@behavior_objectives = Site.first.created_objectives.where( :category => 'behavior' ) - @child.active_assigned_objectives
			@health_objectives = Site.first.created_objectives.where( :category => 'health' ) - @child.active_assigned_objectives
			@house_objectives = Site.first.created_objectives.where( :category => 'houses' ) - @child.active_assigned_objectives
			@hygeine_objectives = Site.first.created_objectives.where( :category => 'hygeine' ) - @child.active_assigned_objectives

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
		
		@assignment = ObjectiveAssignment.find( params[:assignment_id] )
		
		@assignment.update_attributes( :point_value => params[:point_value] ) if params[:point_value]
		@assignment.update_attributes( :description => params[:description] ) if params[:description]

		redirect_to :back
	end
	

	
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	


end