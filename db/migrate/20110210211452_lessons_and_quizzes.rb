class LessonsAndQuizzes < ActiveRecord::Migration
	def self.up
		
		create_table :answers, :force => true do |t| # canned answers for multiple-choice
			t.references	:question
			t.text			:content
			t.boolean		:correct
			t.timestamps
		end
		
		create_table :answerings, :force => true do |t|
			t.references	:quizzing
			t.references	:question
			t.references	:answer
			t.text			:response # for free-response
			t.timestamps
		end
		
		create_table :lessons do |t|
			t.string	:name
			t.string	:lesson_type

			t.timestamps
		end
		
		create_table :lesson_assignments do |t|
			t.references	:user
			t.references	:lesson
			t.references	:creator
			t.integer		:point_value, :default => 1
			t.string		:status
		end
		
		create_table :lesson_screens do |t|
			t.references	:lesson
			t.text			:content
			t.integer		:seq
			t.string		:material_type
		end
		
		create_table :questions, :force => true do |t|
			t.references	:quiz
			t.text			:content
			t.string		:extra_content # e.g. DYK
			t.integer		:point_value, :default => 0
			t.integer		:sequence  # for ordering questions ?
			t.timestamps
		end
		
		create_table :quizzes, :force => true do |t|
			t.references	:lesson
			t.string		:name
			t.references	:created_by
			t.text			:description
			t.integer		:point_value, :default => 0
			t.integer		:level
			t.string		:quiz_type # e.g. for surveys with no right or wrong answers
			t.timestamps
		end
		
		create_table :quizzings, :force => true do |t|
			t.references	:quiz
			t.references	:user
			t.references	:question # Last question for resume?
			t.integer		:score # can derive this from answerings?
			t.timestamps
		end
		
		
	end

	def self.down
	end
end