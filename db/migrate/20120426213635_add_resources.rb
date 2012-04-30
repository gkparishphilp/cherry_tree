class AddResources < ActiveRecord::Migration

	def up
		create_table :resources do |t|
			t.string		:title
			t.string		:content
			t.references	:objective_category
		end
	
		add_column :awards, :url, :string
	end

	def down
		drop_table :resources
	end

end
