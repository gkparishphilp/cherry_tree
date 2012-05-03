require 'csv'

task :cherry_tree_products => :environment do
	CSV.foreach(Rails.root.join('copy','resources','store_products.csv')) do |row|
		p=Product.new
		p.name = row[0]
		p.asin = row[1]
		response = Amazon::Ecs.item_lookup( p.asin, :response_group => "Medium" )
		if item=response.items.first
			p.amazon_name = item.get("ItemAttributes/Title")
			p.amazon_url = item.get("DetailPageURL")
			if item.get('ItemAttributes/ListPrice/FormattedPrice').present?
				p.price = item.get('ItemAttributes/ListPrice/FormattedPrice').gsub("$","")
			end
			apro_age = row[7].split(/,/)
			apro_age_array = Array.new
			for age in apro_age
				apro_age_array << age
			end
			p.appropriate_ages = apro_age_array
			p.amazon_description = item.get('EditorialReviews/EditorialReview/Content')
			p.save
			categories = row[6].split(',')
		
			sc1 = StoreCategory.find_by_name 'Academics & School Readiness'
			sc2 = StoreCategory.find_by_name 'Child Behavior & Independence Skills'
			sc3 = StoreCategory.find_by_name 'Social Skills & Emotional Well-Being'
			sc4 = StoreCategory.find_by_name 'Health & Fitness'
		
			for cat in categories
				case cat
				when 'B'
					ProductCategory.create :product_id => p.id, :store_category_id => sc2.id
				when 'S'
					ProductCategory.create :product_id => p.id, :store_category_id => sc3.id
				when 'H'
					ProductCategory.create :product_id => p.id, :store_category_id => sc4.id
				when 'A'
					ProductCategory.create :product_id => p.id, :store_category_id => sc1.id
				end
			end
		end
	end

end