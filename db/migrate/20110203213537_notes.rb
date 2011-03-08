class Notes < ActiveRecord::Migration
	def self.up
		create_table :notes, :force => true do |t|
			t.references	:sender
			t.references	:font
			t.references	:background
			t.references	:border
			t.string		:font, :default => 'schoolbell' # todo -- deprecate this
			t.string		:font_color, :default => '#333'
			t.string		:background_color, :default => '#ffd'
			t.string		:subject
			t.text			:content
			t.timestamps
		end
		
		create_table :note_deliveries, :force => true do |t|
			t.references	:note
			t.references	:recipient
			t.boolean		:unread, :default => true
			t.string		:status, :default => 'active'
			t.timestamps
		end
	end

	def self.down
		drop_table :notes
		drop_table :note_deliveries
	end
end
