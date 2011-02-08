class CreateMerches < ActiveRecord::Migration
  def self.up
    create_table :merches do |t|
		t.string	:name
		t.string	:description
		t.integer	:price
		t.timestamps
    end
  end

  def self.down
    drop_table :merches
  end
end
