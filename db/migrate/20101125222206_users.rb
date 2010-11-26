class Users < ActiveRecord::Migration
	def self.up
		
		create_table :children, :force => true do |t|
			t.string	:name
			t.string	:pin
		end
		
		# e.g. for families -- join table between children and parents
		create_table :teams, :force => true do |t|
			t.references	:member, :polymorphic => true
			t.string		:role
			t.string		:status
			t.timestamps
		end
		
		create_table :facebook_accounts, :force => true do |t|
			t.references	:owner, :polymorphic => true
			t.string		:name
			t.string		:fb_id
			t.string		:fb_token
			t.string		:status
		
			t.timestamps
		end
	
		create_table :roles, :force => true  do |t|
			t.references	:user
			t.string		:role
			
			t.timestamps
		end
		
		create_table :twitter_accounts, :force => true do |t|
			t.references	:owner, :polymorphic => true
			t.string		:twit_id
			t.string		:token
			t.string		:secret
			t.string		:name
			t.string		:status, :default => 'active'
			
			t.timestamps
		end
	 
		create_table :users, :force => true do |t|
			t.string		:email
			t.string		:name
			t.integer		:score, :default => 0
			t.string		:website_name
			t.string		:website_url
			t.text			:bio
			t.string		:hashed_password
			t.string		:salt
			t.string		:remember_token
			t.datetime		:remember_token_expires_at
			t.string		:activation_code
			t.datetime		:activated_at
			t.string		:status, :default => 'first'
			t.string		:cached_slug
		
			t.string		:orig_ip
			t.string		:last_ip

			t.timestamps
		end
	 
		
	 
		# Need a boatload more indexes	****************
		add_index :users, :name
		add_index :children, :name
		add_index :children, :pin
		add_index :teams, :member_id
		add_index :users, :email, :unique => true
		add_index :users, :activation_code
		add_index :users, :remember_token
		add_index :facebook_accounts, :owner_id
		add_index :twitter_accounts, :owner_id
	end

	def self.down
		drop_table	:facebook_accounts
		drop_table	:roles
		drop_table	:twitter_accounts
		drop_table	:users
	end
end
