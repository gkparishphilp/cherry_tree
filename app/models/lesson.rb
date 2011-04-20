# == Schema Information
# Schema version: 20110420185439
#
# Table name: lessons
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  no_materials :integer(4)
#  lesson_type  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Lesson < ActiveRecord::Base
	has_many	:lesson_screens
	has_many	:lesson_assignments
	acts_as_taggable_on	:keywords
end
