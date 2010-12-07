class ObjectivesController < ApplicationController
	
	def admin
		@objectives = Objective.all
	end
	
	def index
		@objectives = Objective.all
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
	
	def create
		@objective = Objective.new params[:objective]
		if @objective.save
			@objective.assignments.create :user_id => params[:objective][:user_id], :assigned_by_id => @current_user
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