class Product < ActiveRecord::Base
	has_many :product_categories
	has_many :objective_categories, :as => :categories, :through => :product_categories
end