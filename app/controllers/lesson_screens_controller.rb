class LessonScreensController < ApplicationController
	before_filter :get_lesson
	
	def show
		@screen = LessonScreen.find( params[:id] )
	end
	
	private
	
	def get_lesson
		@lesson = Lesson.find( params[:lesson_id] )
	end
	
end