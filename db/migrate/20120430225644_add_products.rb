class AddProducts < ActiveRecord::Migration
  def up
		create_table :products do |t|
			t.string		:name
			t.float			:price
			t.string		:asin
			t.string		:amazon_name
			t.text			:amazon_description
			t.string		:amazon_url
			t.string		:appropriate_ages
		end
		
		create_table :product_categories do |t|
			t.references	:product
			t.references	:objective_category
		end
  end

  def down
		drop_table :products
		drop_table :product_categories
  end

end
