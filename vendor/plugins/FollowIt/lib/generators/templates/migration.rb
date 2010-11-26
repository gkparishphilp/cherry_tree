class FollowItMigration < ActiveRecord::Migration
	def self.up
		create_table :follows, :force => true do |t|
			t.references	:followed, :polymorphic => true, :null => false
			t.references	:follower, :polymorphic => true, :null => false
			t.string		:status, :default => 'active'
			t.string		:follow_type
			
			t.timestamps
		end

		add_index :follows, ["follower_id", "follower_type"], :name => "fk_follows"
		add_index :follows, ["followed_id", "followed_type"], :name => "fk_followed"
	end

	def self.down
		drop_table :follows
	end
end