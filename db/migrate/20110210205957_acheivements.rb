class Acheivements < ActiveRecord::Migration
	def self.up
		create_table :acheivements, :force => true do |t|
			t.string	:name
			t.text		:description
			t.text		:requirements_to_earn # todo
			t.timestamps
		end
		
		create_table :acheivement_earnings, :force => true do |t|
			t.references	:user # the person who earned the acheivement
			t.references	:acheivement
			t.timestamps
		end
		
	end

	def self.down
	end
end
