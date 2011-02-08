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
			@current_user.relate_to @child, :as => params[:child][:role], :nickname => params[:child][:nickname]
			if params[:child][:welcome_message].present?
				note = @current_user.sent_notes.create( :content => params[:child][:welcome_message] )
				note.deliver_to( @child )
				@child.earn_points_for( note )
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
			@recent_note_deliveries = @child.note_deliveries.unread.reverse
			render :private
		else 
			pop_flash "Invalid Child", :error
			redirect_to root_path
			return false
		end
	end

	
end