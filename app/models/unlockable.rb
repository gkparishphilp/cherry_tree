# == Schema Information
# Schema version: 20101209043322
#
# Table name: unlockables
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  points      :integer(4)
#  level       :integer(4)      default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class Unlockable < ActiveRecord::Base
	has_many	:ownings
	has_many	:children, :through => :ownings
	
	has_attached	:avatar
end
