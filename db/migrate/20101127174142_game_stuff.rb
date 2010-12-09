class GameStuff < ActiveRecord::Migration
	def self.up
		create_table :objectives, :force => true do |t|
			t.string		:name
			t.references	:creator
			t.text			:description
			t.integer		:times
			t.string		:period
			t.boolean		:req_approval, :default => false
			t.integer		:points, :default => 1
			t.integer		:level
			t.timestamps
		end
		
		create_table :assignments, :force => true do |t|
			t.references	:user
			t.references	:objective
			t.references	:assigned_by
			t.timestamps
		end
		
		
		create_table :unlockables, :force => true do |t|
			t.string	:name
			t.text		:description
			t.integer	:points
			t.integer	:level, :default => 0
			t.timestamps
		end
		
		create_table :ownings, :force => true do |t|
			t.references	:user
			t.references	:unlockable
			t.timestamps
		end
		
		create_table :earnings, :force => true do |t|
			t.references	:user
			t.references	:earned_for, :polymorphic => true
			t.integer		:points, :default => 1
			t.timestamps
		end
		
		create_table :checkins, :force => true do |t|
			t.references	:user
			t.string		:content
			t.references	:objective # not necessary
			t.string		:status, :default => 'did_not'
			t.integer		:approved_by # this is a user_id
			t.datetime		:approved_at
			t.timestamps
		end
		
		create_table :messages, :force => true do |t|
			t.references	:sender, :polymorphic => true
			t.references	:recipient, :polymorphic => true
			t.string		:subject
			t.text			:content
			t.integer		:points, :default => 0
			t.timestamps
		end
		
		create_table :games, :force => true do |t|
			t.string		:name
			t.references	:created_by
			t.text			:description
			t.text			:content
			t.integer		:points, :default => 0
			t.integer		:level
			t.string		:game_type # e.g. for surveys with no right or wrong answers
			t.timestamps
		end
		
		create_table :playings, :force => true do |t|
			t.references	:game
			t.references	:user
			t.integer		:score # can derive this from answerings?
			t.timestamps
		end
		
		
		create_table :quizzes, :force => true do |t|
			t.string		:name
			t.references	:created_by
			t.text			:description
			t.integer		:points, :default => 0
			t.integer		:level
			t.string		:quiz_type # e.g. for surveys with no right or wrong answers
			t.timestamps
		end
		
		create_table :questions, :force => true do |t|
			t.references	:quiz
			t.text			:content
			t.string		:extra_content # e.g. DYK
			t.integer		:points, :default => 0
			t.integer		:seq  # for ordering questions ?
			t.timestamps
		end
		
		create_table :answers, :force => true do |t|
			t.references	:question
			t.text			:content
			t.boolean		:correct
			t.timestamps
		end
		
		create_table :quizzings, :force => true do |t|
			t.references	:quiz
			t.references	:user
			t.references	:question # Last question for resume?
			t.integer		:score # can derive this from answerings?
			t.timestamps
		end
		
		create_table :answerings, :force => true do |t|
			t.references	:quizzing
			t.references	:question
			t.references	:answer
			t.text			:response # for free-response
			t.timestamps
		end
		
	end
	
	

	def self.down
		drop_table :objectives
	end
end
