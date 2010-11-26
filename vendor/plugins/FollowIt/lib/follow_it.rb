# Follows
require File.dirname(__FILE__) + '/follow_it/follower'
require File.dirname(__FILE__) + '/follow_it/followed'
require File.dirname(__FILE__) + '/follow_it/follow_lib'

ActiveRecord::Base.send( :include, FollowIt::Follower )
ActiveRecord::Base.send( :include, FollowIt::Followed )