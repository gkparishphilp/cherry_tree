class Achievements < ActiveRecord::Migration
	def self.up
		create_table :achievements, :force => true do |t|
			t.string	:name
			t.text		:description
			t.text		:requirements # todo
			t.timestamps
		end
		
		create_table :achievement_earnings, :force => true do |t|
			t.references	:user # the person who earned the achievement
			t.references	:achievement
			t.timestamps
		end
		
	end

	def self.down
	end
end
