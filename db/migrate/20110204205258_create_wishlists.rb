class CreateWishlists < ActiveRecord::Migration
  def self.up
    create_table :wishlists do |t|
		t.references	:user
		t.references	:merch
		t.string		:ASIN
		t.string		:name
		t.string		:description
		t.timestamps
    end
  end

  def self.down
    drop_table :wishlists
  end
end
