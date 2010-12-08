# == Schema Information
# Schema version: 20101208063306
#
# Table name: checkins
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  content      :string(255)
#  objective_id :integer(4)
#  status       :string(255)     default("didit")
#  approved_by  :integer(4)
#  approved_at  :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Checkin < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:objective
	
	scope :update, where( "objective_id is null" )
	
	def expanded_status
		return self.status.gsub( /_/, " " )
	end
end
