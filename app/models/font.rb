# == Schema Information
# Schema version: 20110420185439
#
# Table name: fonts
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  resource_path :string(255)
#  description   :text
#  point_cost    :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class Font < ActiveRecord::Base
	
	def css_class
		return "font_" + self.name
	end
end
