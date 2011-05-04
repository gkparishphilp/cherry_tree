class LessonsController < ApplicationController
	
	def show
		
	end
	
	
	def new
		@lesson = Lesson.new
	end
	
	def create
		@lesson = Lesson.create( params[:lesson] )
	end
	
end