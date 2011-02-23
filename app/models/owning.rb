# == Schema Information
# Schema version: 20110221232318
#
# Table name: ownings
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  ownable_id   :integer(4)
#  ownable_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Owning < ActiveRecord::Base
	belongs_to	:ownable, :polymorphic => true
	belongs_to	:user
	
	scope :awards, where( :ownable_type => 'Award' )
	scope :unlockables, where( :ownable_type => 'Unlockable' )
end
