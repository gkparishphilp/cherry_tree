class Products < ActiveRecord::Migration
  def up
		create_table :products do |t|
			t.string		:name
			t.float			:price
			t.string		:asin
			t.string		:amazon_name
			t.text			:amazon_description
			t.string		:amazon_url
			t.string		:amazon_image_url
			t.string		:appropriate_ages
		end
		
		create_table :store_categories do |t|
			t.string		:name
			t.string		:short_name
			t.integer		:sequence
		end

		create_table :product_categories do |t|
			t.references	:product
			t.references	:store_category
		end
		
  end

  def down
		drop_table :products
		drop_table :store_categories
		drop_table :product_categories
  end

end
