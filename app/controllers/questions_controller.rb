class QuestionsController < ApplicationController
	before_filter	:get_quiz
	
	def admin
		@questions = Question.all
	end
	
	def answer
		@question = Question.find( params[:id] )
		@answer = Answer.find( params[:answer_id] )
		if @answer.correct?
			pop_flash "Yay, You're right!"
		else
			pop_flash "Bummer, wrong answer", :error
		end
		if @question == @quiz.last_question
			redirect_to recap_quiz_path( @quiz )
		else
			redirect_to quiz_question_path( @quiz, @question.next_question )
		end
	end
	
	def recap
		
	end
	
	def index
		@questions = Question.all
	end

	def show
		@question = Question.find( params[:id] )
	end
	
	def new
		@question = Question.new
	end
	
	def edit
		@question = Question.find( params[:id] )
	end
	
	def create
		@question = Question.new( params[:question] )

		if @quiz.questions << @question
			pop_flash "Question was successfully created."
		else
        	pop_flash "Question could not be created.", :error, @question
		end
		redirect_to :back
	end

	def update
		@question = Question.find( params[:id] )

		if @question.update_attributes( params[:question] )
			pop_flash "Question was successfully updated."
		else
			pop_flash "Question could not be updated.", :error, @question
		end
		redirect_to :back
	end

	def destroy
		@question = Question.find( params[:id] )
		@question.destroy
		pop_flash "Question deleted."
		redirect_to :back
	end
	
	private
	
	def get_quiz
		@quiz = Quiz.find params[:quiz_id]
	end

end
