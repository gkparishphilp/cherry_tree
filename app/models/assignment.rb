# == Schema Information
# Schema version: 20110207173417
#
# Table name: assignments
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  objective_id   :integer(4)
#  assigned_by_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class Assignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective
	belongs_to	:assigned_by, :class_name => 'User'
end
