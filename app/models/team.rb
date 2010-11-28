# == Schema Information
# Schema version: 20101127174142
#
# Table name: teams
#
#  id         :integer(4)      not null, primary key
#  child_id   :integer(4)
#  user_id    :integer(4)
#  role       :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
	
	belongs_to	:child
	belongs_to	:user
	
	gets_activities
	
end
