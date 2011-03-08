class Photos < ActiveRecord::Migration
	def self.up
		
		create_table :photo_albums, :force => true do |t|
			t.references	:user
			t.string		:title
			t.text			:description
			t.string		:location
			t.timestamps
		end
		
		create_table :photos, :force => true do |t|
			t.references	:photo_album
			t.string		:title
			t.string		:caption
			t.timestamps
		end
		
	end

	def self.down
	end
end
