# == Schema Information
# Schema version: 20110210211558
#
# Table name: unlockables
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  point_cost  :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Unlockable < ActiveRecord::Base
	has_many	:ownings, :as => :ownable
	has_many	:users, :through => :ownings
end
