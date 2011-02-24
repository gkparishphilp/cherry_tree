# == Schema Information
# Schema version: 20110210211558
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  site_id    :integer(4)
#  user_id    :integer(4)
#  role       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:site
end
