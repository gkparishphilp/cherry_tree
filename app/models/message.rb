# == Schema Information
# Schema version: 20101208063306
#
# Table name: messages
#
#  id             :integer(4)      not null, primary key
#  sender_id      :integer(4)
#  sender_type    :string(255)
#  recipient_id   :integer(4)
#  recipient_type :string(255)
#  subject        :string(255)
#  content        :text
#  points         :integer(4)      default(0)
#  created_at     :datetime
#  updated_at     :datetime
#

class Message < ActiveRecord::Base
	belongs_to :sender, :polymorphic => true
	belongs_to :recipient, :polymorphic => true
	has_many	:earnings, :as => :earned_for
end
