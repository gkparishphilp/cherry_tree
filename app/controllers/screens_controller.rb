class LessonScreensController < ApplicationController
	before_filter :get_lesson
	
	def new
		@screen = Screen.new
	end
	
	def edit
		@screen = Screen.find( params[:id] )
	end
	
	def create
		@screen = @lesson.screens.create( params[:lesson_screen] )
	end
	
	def update
		@screen = Screen.find( params[:id] )
		@screen.update_attributes( params[:lesson_screen] )
	end
	
	def show
		@screen = Screen.find( params[:id] )
		@viewing = LessonViewing.find_or_initialize_by_user_id_and_lesson_id( @current_user.id, @lesson.id )
		@viewing.update_attributes :screen_id => @screen.id

	end
	
	private
	
	def get_lesson
		@lesson = Lesson.find( params[:lesson_id] )
	end
	
end