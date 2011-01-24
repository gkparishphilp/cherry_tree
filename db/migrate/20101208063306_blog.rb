class Blog < ActiveRecord::Migration
	def self.up
		create_table :articles, :force => true do |t|
			t.references	:owner, :polymorphic => true
			t.string		:title
			t.integer		:snip_at
			t.integer		:view_count,	:default => 0
			t.text			:content
			t.text			:excerpt
			t.string		:status, :default => 'publish'
			t.boolean		:comments_allowed
			t.datetime		:publish_at
			t.string		:article_type
			t.string		:cached_slug
			t.timestamps
		end
		
		create_table :comments, :force => true do |t|
			t.references	:user
			t.references	:commentable, :polymorphic => true
			t.references	:reply_to_comment
			t.string		:ip
			t.text			:content
			t.timestamps
		end
		
		add_index :articles, :owner_id
		add_index :articles, :cached_slug, :unique => true
		add_index :comments, :user_id
		add_index :comments, :commentable_id
		add_index :comments, :reply_to_comment_id
		
	end

	def self.down
		drop_table	:articles
		drop_table	:comments
		
	end
end
