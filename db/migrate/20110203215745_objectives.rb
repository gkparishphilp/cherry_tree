class Objectives < ActiveRecord::Migration
	def self.up
		create_table :assignments, :force => true do |t|
			t.references	:user
			t.references	:objective
			t.references	:assigned_by
			t.timestamps
		end
		
		create_table :checkins, :force => true do |t|
			t.references	:user
			t.string		:content
			t.references	:objective # not necessary
			t.string		:status, :default => 'did_not'
			t.integer		:confirmed_by # this is a user_id
			t.datetime		:confirmed_at
			t.timestamps
		end
		
		create_table :objectives, :force => true do |t|
			t.string		:name
			t.references	:creator
			t.text			:description
			t.string		:objective_type  # recurring, one-time
			t.datetime		:due_at # for one-time objectives
			t.integer		:times
			t.string		:period
			t.boolean		:req_checkin, :default => true # true is self-reported by child. False is parent-reported
			t.boolean		:req_confirm, :default => false # parent must confirm checking to award points
			t.integer		:points, :default => 1
			t.integer		:level
			t.timestamps
		end
	end

	def self.down
	end
end
