# == Schema Information
# Schema version: 20101127174142
#
# Table name: children
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)
#  pin               :string(255)
#  birthday          :datetime
#  gender            :string(255)
#  cumulative_points :integer(4)
#  points_balance    :integer(4)
#  level             :integer(4)
#

class Child < ActiveRecord::Base
	
	has_many	:teams
	has_many	:supporters, :through => :teams, :class_name => 'User', :foreign_key => :user_id, :source => :user
	has_many	:parents, :through => :teams, :class_name => 'User', :foreign_key => :user_id, :source => :user,
				:conditions => "role IN ( 'mother', 'father' )"
	has_many	:ownings
	has_many	:unlockables, :through => :ownings
	has_many	:assignments
	has_many	:objectives, :through => :assignments
	has_many	:earnings
	has_many	:checkins
	has_many	:recieved_messages, :as => :recipient, :class_name => 'Message'
	has_many	:sent_messages, :as => :sender, :class_name => 'Message'
	
	has_many	:quizzings, :as => :taker
	
	does_activities
	
	attr_accessor :role, :welcome_message
	
end
