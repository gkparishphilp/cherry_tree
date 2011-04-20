# == Schema Information
# Schema version: 20110420185439
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
	scope :stickers, where( :ownable_type => 'Sticker' )
	scope :fonts, where( :ownable_type => 'Font' )
	scope :backgrounds, where( :ownable_type => 'Background' )
	scope :borders, where( :ownable_type => 'Border' )
end
