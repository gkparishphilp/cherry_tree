class Product < ActiveRecord::Base
	serialize :appropriate_ages
	has_many :product_categories
end