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
			t.references	:earned_for, :polymorphic => true # an objective_assignment, checkin, note, acheivement, etc.
			t.integer		:points_earned
			t.string		:earning_type # to use later? e.g. gift, acheivement, etc???
			t.timestamps
		end
		
		create_table :objectives, :force => true do |t|
			t.string		:name
			t.references	:creator
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
			t.integer		:points_value, :default => 1
			t.timestamps
		end
		
	end

	def self.down
	end
end
