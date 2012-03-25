class LessonsController < ApplicationController
	before_filter :get_child
	
	def show
		@lesson = Lesson.find params[:id]
		@screens = @lesson.screens.order(:sequence)
	end
	
	
	def new
		@lesson = Lesson.new
	end
	
	def create
		@lesson = Lesson.create( params[:lesson] )
		redirect_to new_lesson_screen_path( @lesson )
	end
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end