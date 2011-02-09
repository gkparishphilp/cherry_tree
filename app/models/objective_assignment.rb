# == Schema Information
# Schema version: 20110207173417
#
# Table name: objective_assignments
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  objective_id :integer(4)
#  creator_id   :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class ObjectiveAssignment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
end
