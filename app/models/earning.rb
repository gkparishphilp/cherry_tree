# == Schema Information
# Schema version: 20101127174142
#
# Table name: earnings
#
#  id              :integer(4)      not null, primary key
#  child_id        :integer(4)
#  earned_for_id   :integer(4)
#  earned_for_type :string(255)
#  points          :integer(4)      default(1)
#  approved_at     :datetime
#  approved_by     :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

class Earning < ActiveRecord::Base
	belongs_to	:child
end
