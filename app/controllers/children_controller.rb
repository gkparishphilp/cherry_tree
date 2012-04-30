class ChildrenController < ApplicationController
	
	def new
		@child = Child.new
	end
	
	def login
		render 'sessions/new'
	end
	
	def complete
		@child = Child.find( params[:id] )
	end
	
	def index
		@children = @current_user.children
		@supported_children = @current_user.supported_children
	end
	
	def edit
		@child = Child.find( params[:id] )
		render :layout => false
	end
	
	def update
		@child = Child.find( params[:id] )
		
		unless @child.parents.include?( @current_user ) || @current_user == @child
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
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
			unless @child.parents.include?( @current_user )
				pop_flash "Access Denied", :error
				redirect_to :back
				return false
			end
			render :profile_adult
		end
	end
	
	def create
		@child = Child.new params[:child]
		if @child.save
			@current_user.relate_to @child, :as => params[:child][:role], :nickname => params[:child][:nick]
			process_attachments_for( @child )
			pop_flash "Child Registered."
			redirect_to @child
		else
			pop_flash "Ooops, child not added", :error, @child
			redirect_to :back
		end
		
	end
	
	def show
		@child = Child.find( params[:id] )
		# first things first, is the child logged in?
		if @child == @current_user
			redirect_to :home
		end
		
		unless  @child.relatives.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@activities = @child.activities.order('created_at DESC')
		
		points = @child.point_earnings_since( Time.now.beginning_of_week )
		@chart_data = [points["Academics"], points["Health"], points["Social"], points["Behavior"]]
		@max_points = @chart_data.max.to_i
		@chart_axis_labels = 'Behavior|Social|Health|Academics',"0| #{(@max_points.to_f / 2)}| #{@max_points}"
		@chart_axis_with_labels ='y,x'
	end

	def give_cherries
		points = params[:points].to_i
		obj = Objective.find_by_name "Good Deed"
		child = Child.find params[:id]
		if child.earn_points_for( obj, points)
			pop_flash "Cherries given to #{child.display_name}!"
		else
			pop_flash "Sorry, couldn't give cherries"
		end
		redirect_to :back
	end

end