module FollowIt #:nodoc:
	module Follower

		def self.included( base )
			base.extend ClassMethods
		end

		module ClassMethods
			def acts_as_follower
				has_many :follows, :as => :follower, :dependent => :destroy
				include FollowIt::Follower::InstanceMethods
				include FollowIt::FollowLib
			end
		end

		module InstanceMethods

			# Returns true if this instance is following the object passed as an argument.
			def following?( followed )
				0 < Follow.active.for_follower( self ).for_followed( followed ).count
			end

			# Returns the number of objects this instance is following.
			def follow_count
				Follow.active.for_follower( self ).count
 			end

			# Creates a new follow record for this instance to follow the passed object.
			# Does not allow duplicate records to be created.
			def follow( followed )
				follow = get_follow( followed )
				if follow.blank? && self != followed
					Follow.create( :followed => followed, :follower => self )
				end
			end

			# Deletes the follow record if it exists.
			def stop_following( followed )
				if follow = get_follow( followed )
					follow.delete!
				end
			end

			# Returns the follow records related to this instance by type.
			def follows_by_type( followed_type, options={} )
				Follow.active.includes( :followed ).for_follower( self ).for_followed_type( followed_type ).find( :all, options )
			end

			# Returns the follow records related to this instance with the followed included.
			def all_follows( options={} )
				self.follows.active.includes( :followed) .all( options )
			end

			# Returns the actual records which this instance is following.
			def all_following( options={} )
				all_follows( options ).collect{ |f| f.followed }
			end

			# Returns the actual records of a particular type which this record is following.
			def following_by_type( followed_type, options={} )
				follows = followed_type.constantize.
					includes( :follows ).
					where( 'status = ?', 'active' ).
					where( "follows.follower_id = ? AND follows.follower_type = ? AND follows.followed_type = ?",
							self.id, parent_class_name( self ), followed_type )
				
				if options.has_key?( :limit )
					follows = follows.limit( options[:limit] )
				end
				follows
			end

			def following_by_type_count( followed_type )
				Follow.active.for_follower( self ).for_followed_type( followed_type ).count
			end

			# Allows magic names on following_by_type
			# e.g. following_users == following_by_type('User')
			# Allows magic names on following_by_type_count
			# e.g. following_users_count == following_by_type_count('User')
			def method_missing( m, *args )
				if m.to_s[/following_(.+)_count/]
					following_by_type_count( $1.singularize.classify )
				elsif m.to_s[/following_(.+)/]
					following_by_type( $1.singularize.classify )
				else
					super
				end
			end

	private

			# Returns a follow record for the current instance and followed object.
			def get_follow( followed )
				Follow.active.for_follower( self ).for_followed( followed ).first
			end

    end

  end
end