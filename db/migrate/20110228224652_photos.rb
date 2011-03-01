class Photos < ActiveRecord::Migration
	def self.up
		# don't love the name photo_attachemnts, but these are analogous to stickings
		# they define a photo's being 'stuck' to a note or journal entry
		create_table :photo_attachments, :force => true do |t|
			t.references	:photo
			t.references	:attachable, :polymorphic => true
			t.integer		:top, :default => 0
			t.integer		:left, :default => 0
			t.integer		:width, :default => 64
			t.string		:frame_style
			t.timestamps
		end
		
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
