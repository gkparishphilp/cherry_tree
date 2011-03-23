class Invitations < ActiveRecord::Migration
	def self.up
		create_table :invitations, :force => true do |t|
			t.references	:creator
			t.references	:user 
			t.references	:child
			t.string		:code
			t.string		:role
			t.string		:nickname
			t.string		:message
			t.timestamps
		end
		
		add_index :invitations, :code
		
	end

	def self.down
		drop_table :invitations
	end
	
end
