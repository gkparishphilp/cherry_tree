class GameStuff < ActiveRecord::Migration
	def self.up
		create_table :earnings, :force => true do |t|
			t.references	:user
			t.references	:earned_for, :polymorphic => true
			t.integer		:points, :default => 1
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
		
		create_table :ownings, :force => true do |t|
			t.references	:user
			t.references	:award
			t.timestamps
		end
		
		create_table :playings, :force => true do |t|
			t.references	:game
			t.references	:user
			t.integer		:score # can derive this from answerings?
			t.timestamps
		end
		
		create_table :awards, :force => true do |t|
			t.references	:objective # for awards that are earned, not bought
			t.references	:merch 
			t.string		:name
			t.text			:description
			t.string		:asin # for Amazon products
			t.integer		:points
			t.integer		:level, :default => 0
			t.timestamps
		end
		
	end

	def self.down

		drop_table :objectives
	end
end