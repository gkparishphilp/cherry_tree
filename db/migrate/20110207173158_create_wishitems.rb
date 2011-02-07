class CreateWishitems < ActiveRecord::Migration
  def self.up
    create_table :wishitems do |t|	
		t.references	:child
		t.references	:award
		t.timestamps
    end
  end

  def self.down
    drop_table :wishitems
  end
end
