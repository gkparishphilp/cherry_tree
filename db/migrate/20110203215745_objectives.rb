class Objectives < ActiveRecord::Migration
	def self.up
		
		create_table :checkins, :force => true do |t|
			t.references	:user
			t.string		:content
			t.references	:objective_assignment # not always necessary, e.g. for status
			t.integer		:confirmed_by, :default => 0 # this is a user_id 0, nothing, -1 ignored
			t.datetime		:confirmed_at
			t.boolean		:done
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
			t.references	:objective_category
			t.references	:objective_subcategory
			t.references	:creator, :polymorphic => true
			t.text			:description
			t.integer		:point_value # default for app-objectives to be overridden by the assignment
			t.string		:objective_type # one-time, recurring, milestone, daily, etc. to auto pre-set assignment values?????
			t.timestamps
		end
		
		create_table :objective_assignments, :force => true do |t|
			t.references	:user
			t.references	:objective
			t.references	:creator
			t.references	:award_asignment # to support ability to tie goals to specific awards on successful completion
			t.text			:description # to customize detailed notes for an assignment
			t.integer		:priority # placeholder to prioritize and/or sort objctives
			t.integer		:times # number of required checkins....
			t.string		:period # ... per this unit time
			t.datetime		:due_at # for one-time activities -- i.e. goals
			t.boolean		:req_checkin, :default => true # true is self-reported by child. False is parent-reported
			t.boolean		:req_confirm, :default => false # child earns points automatically
			t.integer		:point_value, :default => 1
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :objective_categories do |t|
			t.string		:name
			t.string		:short_name
			t.integer		:sequence
		end
		
		create_table :objective_subcategories do |t|
			t.references		:objective_category
			t.string		:name
		end	
		
		add_index :objectives, :objective_category_id
		add_index :objective_assignments, :req_confirm
		add_index :objective_assignments, :status
		add_index :objective_assignments, ["user_id","status"], :name => :fk_active_assignments

	end
		

	def self.down
	end
end
