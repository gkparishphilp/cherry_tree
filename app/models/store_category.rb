class StoreCategory < ActiveRecord::Base
	has_many :product_categories
	has_many :products, :through => :product_categories, :source => :product
end