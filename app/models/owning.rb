# == Schema Information
# Schema version: 20110207173417
#
# Table name: ownings
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  award_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Owning < ActiveRecord::Base
	belongs_to	:award
	belongs_to	:user
end
