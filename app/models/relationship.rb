# == Schema Information
# Schema version: 20110228224652
#
# Table name: relationships
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  related_user_id :integer(4)
#  nickname        :string(255)
#  role            :string(255)
#  status          :string(255)     default("active")
#  created_at      :datetime
#  updated_at      :datetime
#

class Relationship < ActiveRecord::Base
	
	after_create :create_symmetric_relationship, :unless => :symmetric_relationship_exists? #only going to do this on create for now
	
	belongs_to	:user
	belongs_to	:related_user, :class_name => 'User'
	
	
	# for sending invitations
	attr_accessor :name, :email
	
	
	def opposite_role
		# try to provide a way to default 
		standard_roles = {
			'brother' => 'sister',
			'friend' => 'friend',
			'teacher' => 'student',
			'doctor' => 'patient', 
			'professional' => 'client',
			'cousin' => 'cousin', 
			'relative' => 'relative'
		}
		
		male_roles = {
			'father' => 'son',
			'mother' => 'son',
			'uncle' => 'nephew',
			'aunt' => 'nephew',
			'grandfather' => 'grandson',
			'grandmother' => 'grandson',
			'stepmother' => 'son',
			'stepfather' => 'son'
		}
		
		female_roles = {
			'father' => 'daughter',
			'mother' => 'daugher',
			'uncle' => 'niece',
			'aunt' => 'niece',
			'grandfather' => 'granddaughter',
			'grandmother' => 'granddaughter',
			'stepmother' => 'daughter',
			'stepfather' => 'daughter'
		}
		roles = standard_roles
		
		self.related_user.gender == 'male' ? roles.merge!( male_roles ) : roles.merge!( female_roles )
		
		if roles.has_key?( role )
			return roles[role]
		elsif roles.invert.has_key?( role )
			return roles.invert[role]
		else
			return 'relative'
		end
		
	end
	
	def symmetric_relationship
		self.related_user.relationships.find_by_related_user_id( self.user.id )
	end
	
	def symmetric_relationship_exists?
		self.related_user.related_users.include?( self.user )
	end
	
	def create_symmetric_relationship
		self.related_user.relationships.create :related_user_id => self.user.id, :role => self.opposite_role, :nickname => self.related_user.display_name
	end
	
	
	
end
