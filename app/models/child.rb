class Child < ActiveRecord::Base
	
	has_many	:teams
	has_many	:supporters, :through => :teams, :class_name => 'User', :foreign_key => :user_id, :source => :user
	has_many	:parents, :through => :teams, :class_name => 'User', :foreign_key => :user_id, :source => :user,
				:conditions => "role IN ( 'mother', 'father' )"
	
	does_activities
	
	attr_accessor :role
	
end