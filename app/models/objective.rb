# == Schema Information
# Schema version: 20101209043322
#
# Table name: objectives
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  creator_id   :integer(4)
#  description  :text
#  times        :integer(4)
#  period       :string(255)
#  req_approval :boolean(1)
#  points       :integer(4)      default(1)
#  level        :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class Objective < ActiveRecord::Base
	has_many	:assignments
	has_many	:users, :through => :assignments
	has_many	:earnings, :as => :earned_for
	
	attr_accessor	:user_id
	
end
