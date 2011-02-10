# == Schema Information
# Schema version: 20110210211558
#
# Table name: point_spendings
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  owning_id    :integer(4)
#  points_spent :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class PointSpending < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:owning
end