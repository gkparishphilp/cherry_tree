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
				msg = Message.create :sender => @current_user, :recipient => @child, 
						:subject => "Welcome, #{@child.name}!",
						:content => params[:child][:welcome_message], :points => 10
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
		if @child.anonymous?
			flash[:notice] = "Invalid Child"
			redirect_to root_path
			return false
		end

		# first things first, public or private?
		if @child == @current_user
			@activities = Activity.feed @child
			@messages = @child.received_messages
			render :private
		else 
			# Let's just show the public profile
			set_meta @child.name, @child.bio
			render	:public
		end
	end

	
end