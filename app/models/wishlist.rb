# == Schema Information
# Schema version: 20110221232318
#
# Table name: wishlists
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  name        :string(255)
#  description :text
#  status      :string(255)     default("active")
#  created_at  :datetime
#  updated_at  :datetime
#

class Wishlist < ActiveRecord::Base
	belongs_to	:user
	has_many	:wishlist_items
end
