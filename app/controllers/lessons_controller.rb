class LessonsController < ApplicationController
	
	def show
		
	end
	
	
	def new
		@lesson = Lesson.new
	end
	
	def create
		@lesson = Lesson.create( params[:lesson] )
		redirect_to new_lesson_screen_path( @lesson )
	end
	
end