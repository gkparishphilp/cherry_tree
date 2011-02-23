# == Schema Information
# Schema version: 20110221232318
#
# Table name: achievement_earnings
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  achievement_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class AchievementEarning < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:achievement
end
