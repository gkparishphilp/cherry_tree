class Messaging < ActiveRecord::Migration
	def self.up
		create_table :messages, :force => true do |t|
			t.references	:sender
			t.string		:subject
			t.text			:content
			t.integer		:points, :default => 0
			t.timestamps
		end
		
		create_table :messagings, :force => true do |t|
			t.references	:message
			t.references	:recipient
			t.boolean		:unread, :default => true
			t.timestamps
		end
	end

	def self.down
		drop_table :messages
		drop_table :messagings
	end
end
