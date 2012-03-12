
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

