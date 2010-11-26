module FollowIt #:nodoc:
	module Followed

		def self.included( base )
			base.extend ClassMethods
		end

		module ClassMethods
			
			def acts_as_followed
				has_many :follows, :as => :followed, :dependent => :destroy, :class_name => 'Follow'
				include FollowIt::Followed::InstanceMethods
				include FollowIt::FollowLib
			end
			
		end


		module InstanceMethods

			# Returns the number of followers a record has.
			def followers_count
				self.follows.active.count
			end

			# Returns the followers by a given type
			def followers_by_type( follower_type, options={} )
				follows = follower_type.constantize.
				includes( :follows ).
				where( 'status = ?', 'active' ).
				where( "follows.followed_id = ? AND follows.followed_type = ? AND follows.follower_type = ?", 
						self.id, parent_class_name( self ), follower_type )
				
				if options.has_key?( :limit )
					follows = follows.limit( options[:limit] )
				end
				follows
			end

			def followers_by_type_count( follower_type )
				self.follows.active.for_follower_type( follower_type ).count
			end

			# Allows magic names on followers_by_type
			# e.g. user_followers == followers_by_type('User')
			# Allows magic names on followers_by_type_count
			# e.g. count_user_followers == followers_by_type_count('User')
			def method_missing( m, *args )
				if m.to_s[/count_(.+)_followers/]
					followers_by_type_count( $1.singularize.classify )
				elsif m.to_s[/(.+)_followers/]
					followers_by_type( $1.singularize.classify )
				else
					super
				end
			end


			# Returns the following records.
			def followers( options={} )
				self.follows.active.includes( :follower ).all( options ).collect{ |f| f.follower }
			end


			# Returns true if the current instance is followed by the passed record
			# Returns false if the current instance is blocked by the passed record or no follow is found
			def followed_by?( follower )
				f = get_follow_for( follower )
				( f && f.active? ) ? true : false
			end


		private

			def get_follow_for( follower ) 
				Follow.for_followed( self ).for_follower( follower ).first
			end

      

		end

	end
end
