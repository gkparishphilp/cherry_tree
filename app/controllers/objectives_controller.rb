class ObjectivesController < ApplicationController
	
	def admin
		@objectives = Objective.all
	end
	
	def index
		if @current_user.is_child?
			@objective_assignments = @current_user.objective_assignments
			
			render :index_child
		else
			@objectives = @current_user.created_objectives
			@objective = @current_user.created_objectives.new
			render :index_adult
		end
	end
	
	def show
		@objective = Objective.find params[:id]
	end
	
	def new
		@objective = Objective.new
	end
	
	def edit
		@objective = Objective.find params[:id]
	end
	
	def set
		@objective = Objective.new
	end
	
	def create
		@objective = @current_user.created_objectives.new params[:objective]
		if @objective.save
			for id in params[:assign_to_ids]
				if assignee = User.find( id )
					@current_user.assign_objective_to( @objective, assignee )
					@current_user.do_activity "assign objective to #{assignee.display_name}", @objective
				end
			end
			pop_flash "Objective Added"
		else
			pop_flash "Ooops, Objective not added", :error, @objective
		end
		redirect_to :back
	end
	
	def update
		@objective = Objective.find params[:id]
		if @objective.update_attributes params[:quiz]
			pop_flash "Objective Updated"
		else
			pop_flash "Ooops, Objective not Updated", :error, @objective
		end
		redirect_to :back
	end
	
end