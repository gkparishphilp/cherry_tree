# == Schema Information
# Schema version: 20110210211558
#
# Table name: objectives
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  creator_id   :integer(4)
#  creator_type :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Objective < ActiveRecord::Base
	belongs_to	:creator, :polymorphic => true
	has_many	:objective_assignments
	has_many	:users, :through => :objective_assignments
	
	accepts_nested_attributes_for	:objective_assignments
end
