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