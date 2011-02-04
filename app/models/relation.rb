# == Schema Information
# Schema version: 20110203215818
#
# Table name: relations
#
#  id         :integer(4)      not null, primary key
#  child_id   :integer(4)
#  user_id    :integer(4)
#  role       :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Relation < ActiveRecord::Base
	
	belongs_to	:child, :foreign_key => :child_id, :class_name => 'Child'
	belongs_to	:user
	
	gets_activities
	
	# for sending invitations
	attr_accessor :name, :email
	
end
