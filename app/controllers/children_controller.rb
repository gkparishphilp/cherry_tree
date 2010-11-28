class ChildrenController < ApplicationController
	
	def new
		@child = Child.new
		render :layout => false
	end
	
	def edit
		@child = Child.find params[:id]
		render :layout => false
	end
	
	def create
		@child = Child.new params[:child]
		if @child.save
			team = @current_user.teams.new :role => params[:child][:role], :child => @child
			if params[:child][:welcome_message].present?
				msg = Message.create :sender => @current_user, :recipient => @child, 
						:subject => "Welcome, #{@child.name}!",
						:content => params[:child][:welcome_message], :points => 10
			end
			if team.save
				pop_flash "Child Added"
			else
				@child.destroy # todo: better to wrap in a transaction....
				pop_flash "Child Not Added", :error, team
			end
		else
			pop_flash "Ooops, Child not added", :error, @child
		end
		redirect_to :back
	end
	
end