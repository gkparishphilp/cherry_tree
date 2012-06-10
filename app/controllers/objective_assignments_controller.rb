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
	end
	
	def deactivate
		@assignment = ObjectiveAssignment.find( params[:assignment_id] )
		@objective = @assignment.objective
		@assignment.update_attributes :status => 'inactive'
		if @objective.objective_category.present? 
			@category_div = "#objective_category_#{@objective.objective_category.id}"
		else
			@category_div = "#custom_objectives"
		end


	end
	
	def requested
		@objective = Objective.find( params[:objective_id] )
			unless @child.active_assigned_objectives.include?( @objective )
				@assignment = @current_user.created_objective_assignments.create :objective => @objective, :user => @child, :status => 'requested', :creator => @current_user, :point_value => @objective.point_value, :description => @objective.description
			end
			pop_flash "Goal requested!", :success
		redirect_to :back
	end

	def unrequested
		@assignment = ObjectiveAssignment.find( params[:assignment_id] )
		@assignment.update_attributes :status => 'inactive' if @assignment.requested?
		redirect_to :back
	end
	
	def require_confirmation
		@assignment = ObjectiveAssignment.find( params[:assignment_id] )
		@assignment.update_attributes :req_confirm => 1
		redirect_to :back
	end
	
	def remove_confirmation
		@assignment = ObjectiveAssignment.find( params[:assignment_id] )
		@assignment.update_attributes :req_confirm => 0
		redirect_to :back
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
			@requested_assignments = @current_user.objective_assignments.requested
			@academic_objectives = Site.first.created_objectives.where( :objective_category_id => 1 ) - @child.active_assigned_objectives
			@behavior_objectives = Site.first.created_objectives.where( :objective_category_id => 2 ) - @child.active_assigned_objectives
			@social_objectives = Site.first.created_objectives.where( :objective_category_id => 3 ) - @child.active_assigned_objectives
			@health_objectives = Site.first.created_objectives.where( :objective_category_id => 4 ) - @child.active_assigned_objectives
			
			render :child_index
		else
			unless @child.parents.include?( @current_user )
				pop_flash "Access Denied", :error
				redirect_to :back
				return false
			end	
			@active_assignments = @child.objective_assignments.active
			@new_assignment = ObjectiveAssignment.new
			@new_assignment.req_confirm = true
		
			@requested_assignments = @child.objective_assignments.requested
			
			@custom_objectives = @current_user.created_objectives - @child.active_assigned_objectives	
			@academic_objectives = Site.first.created_objectives.where( :objective_category_id => 1 ) - @child.active_assigned_objectives
			@behavior_objectives = Site.first.created_objectives.where( :objective_category_id => 2 ) - @child.active_assigned_objectives
			@social_objectives = Site.first.created_objectives.where( :objective_category_id => 3) - @child.active_assigned_objectives
			@health_objectives = Site.first.created_objectives.where( :objective_category_id => 4 ) - @child.active_assigned_objectives

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
	
	def pokki
		@active_assignments = @child.objective_assignments.active - @child.objective_assignments.map{ |assignment| assignment if assignment.checkin_in_last?(Time.now.beginning_of_day)}
		respond_to do |format|
	    	format.json
	  	end
	end
		
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	


end