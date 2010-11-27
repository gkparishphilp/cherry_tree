class GameStuff < ActiveRecord::Migration
	def self.up
		create_table :objectives, :force => true do |t|
			t.string	:name
			t.text		:description
			t.integer	:per
			t.string	:period
			t.integer	:points
			t.integer	:level
		end
		
		create_table :unlockables, :force => true do |t|
			t.string	:name
			t.text		:description
			t.integer	:points_req
			t.integer	:level_req
		end
	end

	def self.down
		drop_table :objectives
	end
end
