# ActivityFeed

require File.dirname(__FILE__) + '/activity_feed/actor'
require File.dirname(__FILE__) + '/activity_feed/target'
require File.dirname(__FILE__) + '/activity_feed/activity_lib'

ActiveRecord::Base.send( :include, ActivityFeed::Actor )
ActiveRecord::Base.send( :include, ActivityFeed::Target )