class CreateWishlists < ActiveRecord::Migration
  def self.up
    create_table :wishlists do |t|
		t.references	:user
		t.references	:merch
		t.string		:asin
		t.string		:name
		t.string		:description
		t.timestamps
    end

	create_table :merch do |t|
		t.string 	:name
		t.string 	:description
		t.integer	:price
		t.timestamps
	end

  end

  def self.down
    drop_table :wishlists
	drop_table :merch
  end

end
