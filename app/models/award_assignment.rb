# == Schema Information
# Schema version: 20110221232318
#
# Table name: award_assignments
#
#  id         :integer(4)      not null, primary key
#  award_id   :integer(4)
#  user_id    :integer(4)
#  creator_id :integer(4)
#  point_cost :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class AwardAssignment < ActiveRecord::Base
	belongs_to	:award
	belongs_to	:user
	belongs_to	:creator, :foreign_key => 'creator_id', :class_name => 'User'
end
