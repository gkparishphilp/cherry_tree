class LessonAssignmentsController < ApplicationController
	before_filter :get_child
	
	def create
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		lesson = Lesson.find( params[:lesson_id] )
		@child.lesson_assignments.create :lesson => lesson, :creator_id => @current_user.id
		
		redirect_to :back
		
		
	end
	
	def index
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		@lessons = Lesson.all
		@quizzes = Quiz.standalone
		
		@new_assignment = @child.lesson_assignments.new
	end
	
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end