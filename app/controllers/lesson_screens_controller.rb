class LessonScreensController < ApplicationController
	before_filter :get_lesson
	
	def show
		@screen = LessonScreen.find( params[:id] )
		@viewing = LessonViewing.find_or_initialize_by_user_id_and_lesson_id( @current_user.id, @lesson.id )
		@viewing.screen = @screen.id
		@viewing.save
	end
	
	private
	
	def get_lesson
		@lesson = Lesson.find( params[:lesson_id] )
	end
	
end