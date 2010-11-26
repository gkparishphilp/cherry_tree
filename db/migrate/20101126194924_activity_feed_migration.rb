class ActivityFeedMigration < ActiveRecord::Migration
	def self.up
		create_table :activities, :force => true do |t|
			t.references	:actor, :polymorphic => true, :null => false
			t.references	:target, :polymorphic => true, :null => false
			t.string		:verb
			t.string		:activity_type
			t.string		:status, :default => 'active'
			
			t.timestamps
		end

		add_index :activities, ["actor_id", "actor_type"], :name => "fk_actor"
		add_index :activities, ["target_id", "target_type"], :name => "fk_target"
	end

	def self.down
		drop_table :activities
	end
end