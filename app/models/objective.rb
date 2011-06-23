# == Schema Information
# Schema version: 20110420185439
#
# Table name: objectives
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  creator_id     :integer(4)
#  creator_type   :string(255)
#  description    :text
#  point_value    :integer(4)
#  category       :string(255)
#  objective_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Objective < ActiveRecord::Base
	belongs_to	:creator, :polymorphic => true
	has_many	:objective_assignments
	has_many	:users, :through => :objective_assignments
	
	def assignment_for( user )
		return self.objective_assignments.where( :user_id => user.id ).first
	end
end
