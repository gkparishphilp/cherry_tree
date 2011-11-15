class QuestionsController < ApplicationController
	before_filter	:get_quiz
	
	def admin
		@questions = Question.all
	end
	
	def answer
		# get stuff
		@question = Question.find( params[:id] )
		if @answer = Answer.find_by_id( params[:answer_id] )
			@quizzing.answer( @question, @answer )
			if @answer.correct?
				pop_flash "Yay, You're right!", :success
			else
				pop_flash "Sorry, wrong answer", :error
			end
		else
			@quizzing.answer( @question, params[:response] )
		end
		
		if @question == @quiz.last_question
			pop_flash "Yay, You're Done!", :notice
			redirect_to recap_quiz_path( @quiz )
		else
			redirect_to quiz_question_path( @quiz, @question.next_question )
		end
	end
	
	def index
		@questions = Question.all
	end

	def show
		@question = Question.find( params[:id] )
		#todo need to scope on quizzing   if @current_user.already_answered?( @question )
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
		@quiz = Quiz.find( params[:quiz_id] )
		@quizzing = Quizzing.find_by_quiz_id_and_user_id( @quiz.id, @current_user.id ) || Quizzing.create( :quiz_id => @quiz.id, :user_id => @current_user.id, :question_id => 1 )
		
	end

end
