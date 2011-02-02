class Users < ActiveRecord::Migration
	def self.up
		
		#create_table :children, :force => true do |t|
		#	t.string	:name
		#	t.string	:pin
		#	t.datetime	:birthday
		#	t.string	:gender
		#	t.integer	:cumulative_points
		#	t.integer	:points_balance
		#	t.integer	:level
		#end
		
		# e.g. for families -- join table between children and parents
		create_table :relations, :force => true do |t|
			t.references	:child
			t.references	:user
			t.string		:role # parent, expert, relative, etc.
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
			t.references	:site
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
			t.string		:type
			t.references	:sites
			t.references	:registered_by # the user_id who entered the child
			t.string		:email
			t.string		:name
			t.integer		:score, :default => 0
			t.datetime		:birthday
			t.string		:gender
			t.integer		:points_earned, :default => 0 # Lifetime
			t.integer		:points_balance, :default => 0
			t.integer		:level, :default => 0
			t.string		:website_name
			t.string		:website_url
			t.text			:bio
			t.string		:hashed_password
			t.string		:salt
			t.string		:remember_token
			t.datetime		:remember_token_expires_at
			t.string		:activation_code
			t.datetime		:activated_at
			t.string		:invitation_code
			t.string		:status, :default => 'first'
			t.string		:cached_slug
			
		
			t.string		:orig_ip
			t.string		:last_ip

			t.timestamps
		end
	 
		
	 
		# Need a boatload more indexes	****************
		add_index :users, :name
	#	add_index :children, :name
	#	add_index :children, :pin
		add_index :relations, :child_id
		add_index :relations, :user_id
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

