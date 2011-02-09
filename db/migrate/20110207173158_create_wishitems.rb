class CreateWishitems < ActiveRecord::Migration
	def self.up
	
		create_table :wishlists, :force => true, do |t|
			t.references	:user
			t.string		:name
			t.text			:description
			t.string		:status, :default => 'active'
			t.timestamps
		
		end
	
	    create_table :wishlist_items, :force => true do |t|
			t.references	:wishlist
			t.string		:name
			t.string		:description
			t.string		:asin
			#t.references	:award
			t.timestamps
		end
		
		add_index :wishlist_items, :wishlist_id
		
	end

	def self.down
		drop_table :wishlists
		drop_table :wishlist_items
	end
end
