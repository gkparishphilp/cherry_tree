# == Schema Information
# Schema version: 20101127174142
#
# Table name: objectives
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  per         :integer(4)
#  period      :string(255)
#  points      :integer(4)      default(1)
#  level       :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Objective < ActiveRecord::Base
	has_many	:assignments
	has_many	:children, :through => :assignments
	has_many	:earnings, :as => :earned_for
end
