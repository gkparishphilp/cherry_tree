# == Schema Information
# Schema version: 20101127174142
#
# Table name: checkins
#
#  id           :integer(4)      not null, primary key
#  child_id     :integer(4)
#  content      :string(255)
#  objective_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class Checkin < ActiveRecord::Base
	belongs_to	:child
	belongs_to	:objective
end
