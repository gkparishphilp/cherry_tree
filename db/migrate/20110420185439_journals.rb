class Journals < ActiveRecord::Migration
	def self.up
		create_table :journals, :force => true do |t|
			t.references	:user
			t.string		:name
			t.boolean		:private, :default => false
			t.string		:status
			t.timestamps
		end
		
		create_table :journal_entries, :force => true do |t|
			t.references	:journal
			t.string		:title
			t.text			:content
			t.references	:font
			t.references	:background
			t.references	:border
			t.boolean		:private, :default => false
			t.string		:status
			t.timestamps
		end
	end

	def self.down
	end
	
end
