# == Schema Information
# Schema version: 20110210211558
#
# Table name: acheivements
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  description          :text
#  requirements_to_earn :text
#  created_at           :datetime
#  updated_at           :datetime
#

class Acheivement < ActiveRecord::Base
	has_many	:acheivement_earnings
		# people who have earned this acheivement
	has_many	:users, :through => :acheivement_earnings
end
