class JournalsAndQuizzes < ActiveRecord::Migration
	def self.up
		
		create_table :answers, :force => true do |t|
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
		
		create_table :journals, :force => true do |t|
			t.references	:user
			t.string		:name
			t.boolean		:private, :default => false
			t.string		:status
			t.timestamps
		end
		
		create_table :journal_entries, :force => true do |t|
			t.references	:journal
			t.string		:title
			t.text			:content
			t.boolean		:private, :default => false
			t.string		:status
			t.timestamps
		end
		
		create_table :questions, :force => true do |t|
			t.references	:quiz
			t.text			:content
			t.string		:extra_content # e.g. DYK
			t.integer		:point_value, :default => 0
			t.integer		:seq  # for ordering questions ?
			t.timestamps
		end
		
		create_table :quizzes, :force => true do |t|
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
		
		create_table :stickers, :force => true do |t|
			t.string		:name
			t.text			:description
			t.string		:sticker_type
			t.integer		:point_cost
			t.timestamps
		end
		
		create_table :stickings, :force => true do |t|
			t.references	:sticker
			t.references	:stickable, :polymorphic => true
			t.integer		:top, :default => 0
			t.integer		:left, :default => 0
			t.integer		:width, :default => 64
			t.timestamps
		end
		
		
	end

	def self.down
	end
end
