# == Schema Information
# Schema version: 20101127174142
#
# Table name: ownings
#
#  id            :integer(4)      not null, primary key
#  child_id      :integer(4)
#  unlockable_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class Owning < ActiveRecord::Base
	belongs_to	:unlockable
	belongs_to	:child
end
