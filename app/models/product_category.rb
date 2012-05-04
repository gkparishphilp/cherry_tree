class ProductCategory < ActiveRecord::Base
	belongs_to :product
	belongs_to :store_category
end