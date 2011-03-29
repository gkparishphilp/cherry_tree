class ActivityFeedMigration < ActiveRecord::Migration
	def self.up
		create_table :activities, :force => true do |t|
			t.references	:user, :null => false
			t.references	:target, :polymorphic => true
			t.string		:verb
			t.string		:activity_type
			t.string		:status, :default => 'active'
			
			t.timestamps
		end

		add_index :activities, "user_id", :name => "fk_activity_user"
		add_index :activities, ["target_id", "target_type"], :name => "fk_target"
	end

	def self.down
		drop_table :activities
	end
end