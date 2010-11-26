class AttachmentsMigration < ActiveRecord::Migration
	def self.up
		create_table :attachments, :force => true do |t|
			t.references	:owner, :polymorphic => true, :null => false
			t.string		:attachment_type
			t.string		:name
			t.string		:format
			t.string		:path
			t.string		:filesize
			t.string		:origin
			t.string		:ip
			t.boolean		:remote, :default => false
			t.string		:status, :default => 'active'
			
			t.timestamps
		end

		add_index :attachments, ["owner_id", "owner_type"], :name => "fk_owner"

	end

	def self.down
		drop_table :attachments
	end
end