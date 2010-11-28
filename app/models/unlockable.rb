# == Schema Information
# Schema version: 20101127174142
#
# Table name: unlockables
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  points_req  :integer(4)
#  level_req   :integer(4)      default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class Unlockable < ActiveRecord::Base
	has_many	:children, :through => :ownings
	
	has_attached	:avatar
end
