# == Schema Information
# Schema version: 20101209043322
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
end
