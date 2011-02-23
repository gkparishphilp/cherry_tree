# == Schema Information
# Schema version: 20110210211558
#
# Table name: acheivement_earnings
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  acheivement_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class AchievementEarning < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:achievement
end
