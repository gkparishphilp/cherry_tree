# == Schema Information
# Schema version: 20110420185439
#
# Table name: backgrounds
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  repeat      :string(255)
#  point_cost  :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Background < ActiveRecord::Base
	has_attached :image
	
	def css_class
		return "bg_" + self.name
	end
end
