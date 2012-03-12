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
			t.string		:name
			t.referecens	:lesson_category
			t.text			:description
			t.string		:lesson_type
			t.timestamps
		end
		
		create_table :lesson_assignments do |t|
			t.references	:user
			t.references	:lesson
			t.references	:creator
			t.integer		:point_value, :default => 1
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :lesson_categories do |t|
			t.string	:name
		end
		
		create_table :screens do |t|
			t.references	:lesson
			t.string		:title
			t.text			:content
			t.integer		:sequence
			t.timestamps
		end
		
		create_table :lesson_viewings do |t|
			t.references	:lesson
			t.references	:user
			t.references 	:screen, :default => 0
			t.timestamps
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
			t.references	:creator
			t.text			:description
			t.integer		:point_value, :default => 0
			t.integer		:level
			t.string		:quiz_type # e.g. for surveys with no right or wrong answers
			t.timestamps
		end
		
		create_table :quiz_assignments do |t|
			t.references	:user
			t.references	:quiz
			t.references	:creator
			t.integer		:point_value, :default => 1
			t.string		:status
			t.timestamps
		end
		
		create_table :quizzings, :force => true do |t|
			t.references	:quiz
			t.references	:user
			t.references	:question # Last question for resume?
			t.integer		:score # can derive this from answerings?
			t.timestamps
		end
		
		add_index :answers, :question_id
		
		add_index :answerings, [ :quizzing_id, :question_id, :answer_id ]
		
		add_index :lesson_assignments, [ :lesson_id, :user_id, :creator_id ]
		
		add_index :screens, [ :lesson_id, :sequence ]
		
		add_index :lesson_viewings, [ :lesson_id, :user_id, :screen_id ]
		
		add_index :questions, [ :quiz_id, :sequence ]
		
		add_index :quizzes, [ :lesson_id, :creator_id ]
		
		add_index :quizzings, [ :quiz_id, :user_id, :question_id ]
		
	end

	def self.down
		
	end
end