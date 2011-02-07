class Messaging < ActiveRecord::Migration
	def self.up
		create_table :notes, :force => true do |t|
			t.references	:sender
			t.string		:font
			t.string		:font_color
			t.string		:background_color
			t.string		:subject
			t.text			:content
			t.integer		:points, :default => 0
			t.timestamps
		end
		
		create_table :note_deliveries, :force => true do |t|
			t.references	:note
			t.references	:recipient
			t.boolean		:unread, :default => true
			t.timestamps
		end
	end

	def self.down
		drop_table :notes
		drop_table :note_deliveries
	end
end
