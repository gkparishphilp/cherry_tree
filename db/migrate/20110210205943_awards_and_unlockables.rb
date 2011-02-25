class AwardsAndUnlockables < ActiveRecord::Migration
	def self.up
		
		create_table :awards, :force => true do |t|
			# awards are customizeable incentives.  They may be amazon products, custom coupons, promises, etc.
			t.references	:creator, :polymorphic => true # the creator is basically the parent who added the award
			t.string		:name
			t.text			:description
			t.string		:award_type # asin will determine amzn prods, maybe use this for coupons vs certificates, etc.
			t.string		:asin # for Amazon products
			t.integer		:point_cost  # TODO - I'm going to re-add this here for now... to be overridden by cost in assignemnt
			t.timestamps
		end
		
		create_table :award_assignments, :force => true do |t|
			t.references	:award
			t.references	:user  # the user that this award is available to
			t.references	:creator # who created the assignemnt
			t.integer		:point_cost
			t.timestamps
		end
		
		create_table :unlockables, :force => true do |t|
			t.string	:name
			t.text		:description
			t.string	:unlockable_type
			t.integer	:point_cost
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
