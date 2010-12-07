# == Schema Information
# Schema version: 20101127174142
#
# Table name: playings
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  user_id    :integer(4)
#  score      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Playing < ActiveRecord::Base
	belongs_to	:game
	belongs_to	:user
end
