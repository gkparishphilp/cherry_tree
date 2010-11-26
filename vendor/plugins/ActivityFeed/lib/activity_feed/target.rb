module ActivityFeed #:nodoc:
	module Target

		def self.included( base )
			base.extend ClassMethods
		end

		module ClassMethods
			
			def gets_activities
				has_many :activities, :as => :target, :dependent => :destroy
				include ActivityFeed::Target::InstanceMethods
				include ActivityFeed::ActivityLib
			end
			
		end

		module InstanceMethods

			# Creates an activity
			def got_activity( verb, target )
				self.activities.create :verb => verb, :target => target
			end
			
			
			
		end
	
	
	end
end