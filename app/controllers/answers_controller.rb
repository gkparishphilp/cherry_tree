class AnswersController < ApplicationController

	def admin
		@answers = Answer.all
	end
	
	def index
		@answers = Answer.all
	end

	def show
		@answer = Answer.find( params[:id] )
	end
	
	def new
		@answer = Answer.new
	end
	
	def edit
		@answer = Answer.find( params[:id] )
	end
	
	def create
		@answer = Answer.new( params[:answer] )

		if @answer.save
			pop_flash "Answer was successfully created."
		else
        	pop_flash "Answer could not be created.", :error, @answer
		end
		redirect_to :back
	end

	def update
		@answer = Answer.find( params[:id] )

		if @answer.update_attributes( params[:answer] )
			pop_flash "Answer was successfully updated."
		else
			pop_flash "Answer could not be updated.", :error, @answer
		end
		redirect_to :back
	end

	def destroy
		@answer = Answer.find( params[:id] )
		@answer.destroy
		pop_flash "Answer deleted."
		redirect_to :back
	end

end
