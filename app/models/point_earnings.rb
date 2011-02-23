# == Schema Information
# Schema version: 20110221232318
#
# Table name: point_earnings
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  earned_for_id   :integer(4)
#  earned_for_type :string(255)
#  points_earned   :integer(4)
#  earning_type    :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class PointEarnings < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:earned_for, :polymorphic => true

	scope :dated_between, lambda { |*args| 
		where( "created_at between ? and ?", args.first, args.second ) 
	}
end
