class QuizzesController < ApplicationController

	def admin
		@quizzes = Quiz.all
	end
	
	def index
		@quizzes = Quiz.all
	end

	def show
		@quiz = Quiz.find( params[:id] )
	end
	
	def inspect
		@quiz = Quiz.find( params[:id] )
	end
	
	def new
		@quiz = Quiz.new
	end
	
	def edit
		@quiz = Quiz.find( params[:id] )
	end
	
	def create
		@quiz = Quiz.new( params[:quiz] )

		if @quiz.save
			pop_flash "Quiz was successfully created."
		else
        	pop_flash "Quiz could not be created.", :error, @quiz
		end
		redirect_to :back
	end

	def update
		@quiz = Quiz.find( params[:id] )

		if @quiz.update_attributes( params[:quiz] )
			pop_flash "Quiz was successfully updated."
		else
			pop_flash "Quiz could not be updated.", :error, @quiz
		end
		redirect_to :back
	end
	
	def recap
		@quiz = Quiz.find( params[:id] )
		@quizzing = @quiz.quizzings.find_by_user_id_and_quiz_id( @current_user, @quiz )
		@num_right = 0
		for answering in @quizzing.answerings do
			@num_right += 1 if answering.answer == answering.question.correct_answer
		end
		@quizzing.update_attributes :score => @num_right
	end

	def destroy
		@quiz = Quiz.find( params[:id] )
		@quiz.destroy
		pop_flash "Quiz deleted."
		redirect_to :back
	end

end
