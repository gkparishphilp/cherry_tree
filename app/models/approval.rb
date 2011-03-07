# == Schema Information
# Schema version: 20110228224652
#
# Table name: approvals
#
#  id         :integer(4)      not null, primary key
#  checkin_id :integer(4)
#  creator_id :integer(4)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Approval < ActiveRecord::Base
	belongs_to :checkin
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
	
end
