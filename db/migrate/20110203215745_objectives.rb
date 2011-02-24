class Objectives < ActiveRecord::Migration
	def self.up
		
		create_table :checkins, :force => true do |t|
			t.references	:user
			t.string		:content
			t.references	:objective_assignment # not always necessary, e.g. for status
			t.string		:status, :default => 'did_not'
			t.integer		:confirmed_by # this is a user_id
			t.datetime		:confirmed_at
			t.timestamps
		end
		
		create_table :point_earnings, :force => true do |t|
			t.references	:user # the person who earned this
			t.references	:earned_for, :polymorphic => true # an objective_assignment, checkin, note, achievement, etc.
			t.integer		:points
			t.string		:earning_type # to use later? e.g. gift, achievement, etc???
			t.timestamps
		end
		
		create_table :objectives, :force => true do |t|
			t.string		:name
			t.references	:creator, :polymorphic => true
			t.text			:description
			t.timestamps
		end
		
		create_table :objective_assignments, :force => true do |t|
			t.references	:user
			t.references	:objective
			t.references	:creator
			t.integer		:times
			t.datetime		:due_at # for one-time activities -- i.e. goals
			t.string		:period
			t.boolean		:req_checkin, :default => true # true is self-reported by child. False is parent-reported
			t.boolean		:req_confirm, :default => false # parent must confirm checkin to award points
			t.integer		:point_value, :default => 1
			t.timestamps
		end
		
		create_table :weekly_approvals, :force => true do |t|
			t.references	:objective_assignment
			t.references	:creator 
			t.date			:week_ending
			t.string		:status
			t.timestamps
		end
	end
		

	def self.down
	end
end
