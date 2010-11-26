module ActivityFeed #:nodoc:
	module Actor

		def self.included( base )
			base.extend ClassMethods
		end

		module ClassMethods
			
			def does_activities
				has_many :activities, :as => :actor, :dependent => :destroy
				include ActivityFeed::Actor::InstanceMethods
				include ActivityFeed::ActivityLib
			end
			
		end

		module InstanceMethods

			# Creates an activity
			def do_activity( verb, target )
				verb = past_tense verb
				self.activities.create :verb => verb, :target => target unless duplicate_activity?( verb, target, 5.minutes.ago )
			end
			
			def activities_by_target_type( target_type, options={} )
				activities = Activity.active.
				where( "activities.actor_id = ? AND activities.actor_type = ? AND activities.target_type = ?", 
						self.id, self.class.name, target_type )
				
				if options.has_key?( :limit )
					activities = activities.limit( options[:limit] )
				end
				activities
			end
			
			def activities_for_target( target, options={} )
				activities = Activity.active.
				where( "activities.actor_id = ? AND activities.actor_type = ? AND activities.target_id = ? AND activities.target_type = ?", 
						self.id, self.class.name, target.id, target.class.name )
				
				if options.has_key?( :limit )
					activities = activities.limit( options[:limit] )
				end
				activities
			end
			
			
			def method_missing( m, *args )
				if m.to_s[/do_(.+)/] || m.to_s[/did_(.+)/]
					verb = whitespace $1
					target = args.first
					do_activity( verb, target )
				else
					super
				end
			end
			
			def duplicate_activity?( verb, target, since )
				0 < Activity.active.recent( since ).where( "activities.actor_id = ? AND activities.actor_type = ? AND activities.target_id = ? AND activities.target_type = ? AND verb = ? ", 
							self.id, self.class.name, target.id, target.class.name, verb ).count
			end
			
		end
	
	
	end
end