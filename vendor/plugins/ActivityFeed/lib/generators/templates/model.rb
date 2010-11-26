class Activity < ActiveRecord::Base
  
	belongs_to :actor, :polymorphic => true
	belongs_to :target, :polymorphic => true
	
	
	scope :for_actor, lambda { |actor| where( ["actor_id = ? AND actor_type = ?", 
									actor.id, actor.class.name ] ) }
	scope :for_target, lambda { |target| where( ["target_id = ? AND target_type = ?", 
										target.id, target.class.name] ) }
	scope :for_actor_type, lambda { |actor_type| where( "actor_type = ?", actor_type ) }
	scope :for_target_type, lambda { |target_type| where( "target_type = ?", target_type ) }
	scope :active, where( "status = 'active'" )
	
	
	# Class methods
	def self.recent( since = 1.week.ago )
		where( "created_at > ?", since )
	end
	
	def self.feed( *arg_list ) # take a list of gets_activities objects and generate a feed for them
		return Activity.all if arg_list.empty?
		activities = []
		for obj in arg_list
			if obj.respond_to? 'each'
				for child in obj
					next unless child.respond_to? 'activities'
					activities += child.activities
				end
			else
				next unless obj.respond_to? 'activities'
				activities += obj.activities
			end
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
		if self.actor.respond_to? 'name' 
			subj = self.actor.name 
		else
			subj = self.actor.title
		end
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