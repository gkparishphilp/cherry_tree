class ChildrenController < ApplicationController
	
	def new
		@child = Child.new
		render :layout => false
	end
	
	def login
		render 'sessions/new'
	end
	
	def edit
		@child = Child.find params[:id]
		render :layout => false
	end
	
	def create
		@child = Child.new params[:child]
		if @child.save
			relation = @current_user.relations.new :role => params[:child][:role], :child_id => @child.id
			if params[:child][:welcome_message].present?
				msg = @current_user.sent_messages.create( :content => params[:child][:welcome_message] )
				msg.deliver_to( @child )
				@child.earn_points_for( msg )
			end
			if relation.save
				pop_flash "Child Added"
			else
				@child.destroy # todo: better to wrap in a transaction....
				pop_flash "Child Not Added", :error, relation
			end
		else
			pop_flash "Ooops, Child not added", :error, @child
		end
		redirect_to :back
	end
	
	def show
		@child = Child.find( params[:id] )
		# first things first, is the child logged in?
		if @child == @current_user
			@activities = Activity.feed @child
			@messages = @child.messagings.unread.reverse
			render :private
		else 
			pop_flash "Invalid Child", :error
			redirect_to root_path
			return false
		end
	end

	
end