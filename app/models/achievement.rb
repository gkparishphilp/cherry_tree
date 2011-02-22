# == Schema Information
# Schema version: 20110210211558
#
# Table name: achievements
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  description          :text
#  requirements_to_earn :text
#  created_at           :datetime
#  updated_at           :datetime
#

class Achievement < ActiveRecord::Base
	has_many	:achievement_earnings
		# people who have earned this achievement
	has_many	:users, :through => :achievement_earnings
end
