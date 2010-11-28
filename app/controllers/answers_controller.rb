class AnswersController < ApplicationController
	
	def new
		@answer = Answer.new
	end
	
	def edit
		@answer = Answer.find params[:id]
	end
	
	def create
		@answer = Answer.new params[:answer]
		if @answer.save
			pop_flash "Answer Added"
		else
			pop_flash "Ooops, Answer not added", :error, @answer
		end
		redirect_to :back
	end
	
end