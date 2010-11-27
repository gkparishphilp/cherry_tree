# == Schema Information
# Schema version: 20101127002241
#
# Table name: children
#
#  id       :integer(4)      not null, primary key
#  name     :string(255)
#  pin      :string(255)
#  birthday :datetime
#  gender   :string(255)
#

class Child < ActiveRecord::Base
	
	has_many	:teams
	has_many	:supporters, :through => :teams, :class_name => 'User', :foreign_key => :user_id, :source => :user
	has_many	:parents, :through => :teams, :class_name => 'User', :foreign_key => :user_id, :source => :user,
				:conditions => "role IN ( 'mother', 'father' )"
	
	does_activities
	
	attr_accessor :role
	
end
