class Forums < ActiveRecord::Migration
	def self.up
		create_table :forums, :force => true do |t|
			t.references	:owner, :polymorphic => true
			t.string		:title
			t.string		:availability
			t.string		:description
			t.string		:cached_slug
			t.timestamps
		end
		
		create_table :posts, :force => true do |t|
			t.references	:forum
			t.references	:topic
			t.references	:reply_to_post
			t.references	:user
			t.string		:title
			t.text			:content
			t.integer		:view_count, :default => 0
			t.string		:ip
			t.string		:type
			t.string		:cached_slug
			t.timestamps
		end
		
		add_index :forums, :owner_id
		add_index :forums, :cached_slug, :unique => true
		add_index :posts, :forum_id
		add_index :posts, :topic_id
		add_index :posts, :reply_to_post_id
		add_index :posts, :user_id
		add_index :posts, :cached_slug, :unique => true
		
	end

	def self.down
		drop_table	:forums
		drop_table	:posts
	end
end