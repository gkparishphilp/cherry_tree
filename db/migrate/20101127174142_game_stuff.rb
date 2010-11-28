class GameStuff < ActiveRecord::Migration
	def self.up
		create_table :objectives, :force => true do |t|
			t.string	:name
			t.text		:description
			t.integer	:per
			t.string	:period
			t.integer	:points, :default => 1
			t.integer	:level
			t.timestamps
		end
		
		create_table :assignments, :force => true do |t|
			t.references	:child
			t.references	:objective
			t.references	:assigned_by
			t.timestamps
		end
		
		
		create_table :unlockables, :force => true do |t|
			t.string	:name
			t.text		:description
			t.integer	:points_req
			t.integer	:level_req, :default => 0
			t.timestamps
		end
		
		create_table :ownings, :force => true do |t|
			t.references	:child
			t.references	:unlockable
			t.timestamps
		end
		
		create_table :earnings, :force => true do |t|
			t.references	:child
			t.references	:earned_for, :polymorphic => true
			t.integer		:points, :default => 1
			t.datetime		:approved_at
			t.integer		:approved_by # this is a user_id
			t.timestamps
		end
		
		create_table :checkins, :force => true do |t|
			t.references	:child
			t.string		:content
			t.references	:objective # not necessary
			t.timestamps
		end
		
		create_table :messages, :force => true do |t|
			t.references	:sender, :polymorphic => true
			t.references	:recipient, :polymorphic => true
			t.string		:subject
			t.text			:message
			t.integer		:points, :default => 0
			t.timestamps
		end
		
	end
	
	

	def self.down
		drop_table :objectives
	end
end
