# == Schema Information
# Schema version: 20110420185439
#
# Table name: point_spendings
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  owning_id  :integer(4)
#  points     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class PointSpending < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:owning
end
