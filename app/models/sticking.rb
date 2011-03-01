# == Schema Information
# Schema version: 20110228224652
#
# Table name: stickings
#
#  id             :integer(4)      not null, primary key
#  sticker_id     :integer(4)
#  stickable_id   :integer(4)
#  stickable_type :string(255)
#  top            :integer(4)      default(0)
#  left           :integer(4)      default(0)
#  width          :integer(4)      default(64)
#  created_at     :datetime
#  updated_at     :datetime
#

class Sticking < ActiveRecord::Base

	belongs_to	:sticker
	belongs_to	:stickable
	
end
