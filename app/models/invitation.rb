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
	belongs_to :creator, :polymorphic => true
	belongs_to :invited_to, :polymorphic => true
	before_save :generate_invitation_code
	attr_accessor :name, :nickname, :email, :role
		
	def setup(invitor, invitee)
		self.creator = invitor
		self.user = invitee
		self.save
	end

	def generate_invitation_code
		random_string = rand(1000000000).to_s + Time.now.to_s
		if self.code == nil
			self.code = Digest::SHA1.hexdigest random_string
		end
	end
	
end

