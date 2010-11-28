class QuestionsController < ApplicationController
	
	def new
		@question = Question.new
	end
	
	def edit
		@question = Question.find params[:id]
	end
	
	def create
		@question = Question.new params[:question]
		if @question.save
			pop_flash "Question Added"
		else
			pop_flash "Ooops, Question not added", :error, @question
		end
		redirect_to :back
	end
	
end