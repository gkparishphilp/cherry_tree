require 'csv'

task :load_store => :environment do
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
			p.appropriate_ages = row[7].split(',')
			p.amazon_description = item.get('EditorialReviews/EditorialReview/Content')
			p.save
			categories = row[6].split(',')
		
			c1 = ObjectiveCategory.find_by_name 'Academics & School Readiness'
			c2 = ObjectiveCategory.find_by_name 'Child Behavior & Independence Skills'
			c3 = ObjectiveCategory.find_by_name 'Social Skills & Emotional Well-Being'
			c4 = ObjectiveCategory.find_by_name 'Health & Fitness'
		
			for cat in categories
				case cat
				when 'B'
					ProductCategory.create :product_id => p.id, :objective_category_id => c2.id
				when 'S'
					ProductCategory.create :product_id => p.id, :objective_category_id => c3.id
				when 'H'
					ProductCategory.create :product_id => p.id, :objective_category_id => c4.id
				when 'A'
					ProductCategory.create :product_id => p.id, :objective_category_id => c1.id
				end
			end
		end
	end

end