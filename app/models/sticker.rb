# == Schema Information
# Schema version: 20110420185439
#
# Table name: stickers
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  point_cost  :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Sticker < ActiveRecord::Base
	has_attached	:avatar
end
