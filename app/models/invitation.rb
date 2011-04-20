# == Schema Information
# Schema version: 20110420185439
#
# Table name: invitations
#
#  id         :integer(4)      not null, primary key
#  creator_id :integer(4)
#  user_id    :integer(4)
#  child_id   :integer(4)
#  code       :string(255)
#  role       :string(255)
#  nickname   :string(255)
#  message    :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Invitation < ActiveRecord::Base
	belongs_to :user
	belongs_to :creator, :class_name => 'User'
	belongs_to :child
	before_save :generate_invitation_code
	
	attr_accessor :name, :email


	def generate_invitation_code
		if self.code == nil
			random_string = rand(1000000000).to_s + Time.now.to_s
			self.code = Digest::SHA1.hexdigest random_string
		end
	end
	
end

