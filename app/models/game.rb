# == Schema Information
# Schema version: 20110203215818
#
# Table name: games
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  created_by_id :integer(4)
#  description   :text
#  content       :text
#  points        :integer(4)      default(0)
#  level         :integer(4)
#  game_type     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Game < ActiveRecord::Base
	before_create	:set_content_canvass
	
	has_many	:playings
	has_many	:players, :through => :playings, :foreign_key => :user_id, :class_name => 'User'
	
private

	def set_content_canvass
		self.content = "<div id='canvascontainer'><canvas id='canvas' width='300' height='300'></canvas><div style='text-align:center'><input type='submit' value='Play #{self.name}' id='runButton' /></div></div>" unless self.content.present?
	end
end
