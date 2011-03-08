# == Schema Information
# Schema version: 20110228224652
#
# Table name: borders
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  point_cost :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Border < ActiveRecord::Base
	
end
