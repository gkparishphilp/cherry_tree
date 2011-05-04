# == Schema Information
# Schema version: 20110420185439
#
# Table name: lesson_viewings
#
#  id         :integer(4)      not null, primary key
#  lesson_id  :integer(4)
#  user_id    :integer(4)
#  screen_id  :integer(4)      default(0)
#  created_at :datetime
#  updated_at :datetime
#

class LessonViewing < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:lesson
	belongs_to	:screen
end
