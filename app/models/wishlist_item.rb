# == Schema Information
# Schema version: 20110221232318
#
# Table name: wishlist_items
#
#  id          :integer(4)      not null, primary key
#  wishlist_id :integer(4)
#  name        :string(255)
#  description :string(255)
#  asin        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class WishlistItem < ActiveRecord::Base
	belongs_to	:wishlist
end
