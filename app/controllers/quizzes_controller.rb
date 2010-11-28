class QuizzesController < ApplicationController
	
	def admin
		@quizzes = Quiz.all
	end
	
	def index
		@quizzes = Quiz.all
	end
	
	def show
		@quiz = Quiz.find params[:id]
	end
	
	def new
		@quiz = Quiz.new
	end
	
	def edit
		@quiz = Quiz.find params[:id]
	end
	
	def create
		@quiz = Quiz.new params[:quiz]
		if @quiz.save
			pop_flash "Quiz Added"
		else
			pop_flash "Ooops, Quiz not added", :error, @quiz
		end
		redirect_to :back
	end
	
	def update
		@quiz = Quiz.find params[:id]
		if @quiz.update_attributes params[:quiz]
			pop_flash "Quiz Updated"
		else
			pop_flash "Ooops, Quiz not Updated", :error, @quiz
		end
		redirect_to :back
	end
	
end