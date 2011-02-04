# == Schema Information
# Schema version: 20110203215818
#
# Table name: earnings
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  earned_for_id   :integer(4)
#  earned_for_type :string(255)
#  points          :integer(4)      default(1)
#  created_at      :datetime
#  updated_at      :datetime
#

class Earning < ActiveRecord::Base
	belongs_to	:child
end
