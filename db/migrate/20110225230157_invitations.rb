class Invitations < ActiveRecord::Migration
  def self.up
	create_table :invitations, :force => true do |t|
		t.references	:creator, :polymorphic => true # the creator is basically who created the invitation
		t.references	:user 
		t.references	:invited_to, :polymorphic => true #Can be a child, the site, or other TBD's like events, etc.
		t.string		:code
		t.timestamps
	end
	
	add_index :invitations, :code
  end

  def self.down
	remove_index :invitations, :code
	drop_table :invitations
  end
end
