# == Schema Information
# Schema version: 20110228224652
#
# Table name: invitations
#
#  id              :integer(4)      not null, primary key
#  creator_id      :integer(4)
#  creator_type    :string(255)
#  user_id         :integer(4)
#  invited_to_id   :integer(4)
#  invited_to_type :string(255)
#  code            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Invitation < ActiveRecord::Base
	belongs_to :user
end
