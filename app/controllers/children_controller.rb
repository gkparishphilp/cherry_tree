class ChildrenController < ApplicationController
	
	def new
		@child = Child.new
	end
	
	def login
		render 'sessions/new'
	end
	
	def home
		@activities = Activity.feed @child
	end
	
	def index
		@children = @current_user.children
	end
	
	def edit
		@child = Child.find( params[:id] )
		render :layout => false
	end
	
	def update
		@child = Child.find( params[:id] )
		if @child.update_attributes( params[:child] )
			process_attachments_for( @child )
			pop_flash 'Successfully updated.'	
		else
			pop_flash 'Oooops, Not updated...', 'error', @child
		end
		
		redirect_to :back
	end
	
	def profile
		@child = Child.find( params[:id] )
		if @current_user.is_child?
			render :profile_child
		else
			render :profile_adult
		end
	end
	
	def create
		@child = Child.new params[:child]
		if @child.save
			@current_user.relate_to @child, :as => params[:child][:role], :nickname => params[:child][:nick]
			process_attachments_for( @child )
			if params[:child][:welcome_message].present?
				note = @current_user.sent_notes.create( :content => params[:child][:welcome_message] )
				note.deliver_to( @child )
				#@child.earn_points_for( note )
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
			redirect_to :home
		end
	end

	
end