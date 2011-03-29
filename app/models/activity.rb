# == Schema Information
# Schema version: 20110228224652
#
# Table name: activities
#
#  id            :integer(4)      not null, primary key
#  user_id       :integer(4)      not null
#  target_id     :integer(4)
#  target_type   :string(255)
#  verb          :string(255)
#  activity_type :string(255)
#  status        :string(255)     default("active")
#  created_at    :datetime
#  updated_at    :datetime
#

class Activity < ActiveRecord::Base
  
	belongs_to :user
	belongs_to :target, :polymorphic => true
	

	scope :for_target, lambda { |target| where( ["target_id = ? AND target_type = ?", 
										target.id, target.class.name] ) }
	scope :for_target_type, lambda { |target_type| where( "target_type = ?", target_type ) }
	scope :active, where( "status = 'active'" )
	
	
	# Class methods
	def self.recent( since = 1.week.ago )
		where( "created_at > ?", since )
	end
	
	def self.feed( *user_list ) # take a list of users objects and generate a feed for them
		return Activity.all if user_list.empty?
		activities = []
		user_list.flatten!
		for user in user_list
			activities += user.activities
		end
		activities.uniq!
		activities.sort! { |a, b| b.created_at <=> a.created_at }
		return activities
	end

	# instance methods
	def active?
		self.status == 'active'
	end
	
	def to_s
		subj = self.user.display_name

		if self.target.respond_to? 'name' 
			obj = self.target.name
		else
			obj = self.target.title 
		end
		return "#{subj} #{self.verb} #{obj}"
	end
	
	def delete!
		self.update_attribute( :status => 'deleted' )
	end
  
end
