class AwardsAndUnlockables < ActiveRecord::Migration
	def self.up
		
		create_table :awards, :force => true do |t|
			# awards are customizeable incentives.  They may be amazon products, custom coupons, promises, etc.
			t.references	:creator, :polymorphic => true # the creator is basically the parent who added the award
			t.string		:name
			t.text			:description
			t.string		:asin # for Amazon products
			t.integer		:point_cost  # TODO - I'm going to re-add this here for now... to be overridden by cost in assignemnt
			t.string		:category # material, time, experience
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :award_assignments, :force => true do |t|
			t.references	:award
			t.references	:user  # the user that this award is available to
			t.references	:creator # who created the assignemnt
			t.text			:description # TODO - implement -- let parent add/over-ride award description and add details
			t.integer		:point_cost
			t.boolean		:recurring, :default => true # an award is eligible for multiple unlocks.  False for one-time awards
			t.string		:status
			t.timestamps
		end
		
		create_table :fonts, :force => true do |t|
			t.string	:name
			t.string	:resource_path
			t.text		:description
			t.integer	:point_cost
			t.timestamps
		end
		
		create_table :backgrounds, :force => true do |t|
			t.string	:name
			t.text		:description
			t.string	:repeat
			t.integer	:point_cost
			t.timestamps
		end
		
		create_table :borders, :force => true do |t|
			t.string	:name
			t.integer	:point_cost
			t.timestamps
		end
		
		create_table :stickers, :force => true do |t|
			t.string		:name
			t.text			:description
			t.integer		:point_cost
			t.timestamps
		end
		
		# These are things that appear on a page
		create_table :page_elements do |t|
			t.references	:page, :polymorphic => true # note, or journal entry
			t.references	:photo
			t.references	:sticker
			t.string		:type			# header, paragraph, image
			t.integer		:top, :default => 0
			t.integer		:left, :default => 0
			t.integer		:width, :default => 100
			t.integer		:height, :default => 24
			t.text			:copy
			t.string		:caption # for pictures only
			t.timestamps
		end
		
		
		create_table :ownings, :force => true do |t|
			t.references	:user
			t.references	:ownable, :polymorphic => true
			t.timestamps
		end
		
		create_table :point_spendings, :force => true do |t|
			t.references	:user
			t.references	:owning
			t.integer		:points
			t.timestamps
		end
		
		
		
	end

	def self.down
	end
end
