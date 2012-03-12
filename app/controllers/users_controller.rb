class UsersController < ApplicationController
	before_filter   :require_admin,   :only => [ :admin, :destroy ]
	before_filter	:require_login, :only => [ :home, :edit, :update ]

	
	def home
		if @current_user.is_child?
			@screen_item = @current_user.best_item
			@activities = Activity.feed( @current_user )
			@relevant_assignment, @relevant_assignment_parent, @num_assignments = @current_user.most_relevant
			
			@assignments = @current_user.objective_assignments.active - @current_user.objective_assignments.checked_in
			
			if @relevant_assignment_parent.is_a?( Lesson )
				@viewing = LessonViewing.find_or_initialize_by_user_id_and_lesson_id( @current_user.id, @relevant_assignment_parent.id )
				@viewing.update_attributes :updated_at => Time.now
			end
		
			render 'child/home'
		else
			if @current_user.children.empty? && @current_user.supported_children.empty?
				redirect_to new_child_path
			else
				@activities = Activity.feed( @current_user, @current_user.children, @current_user.supported_children )
				render 'adult/home'
			end
		end
	end
	

	
end









