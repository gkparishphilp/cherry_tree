# == Schema Information
# Schema version: 20101127174142
#
# Table name: assignments
#
#  id             :integer(4)      not null, primary key
#  child_id       :integer(4)
#  objective_id   :integer(4)
#  assigned_by_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class Assignment < ActiveRecord::Base
	belongs_to	:child
	belongs_to	:objective
end
