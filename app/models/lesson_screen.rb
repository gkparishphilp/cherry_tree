# == Schema Information
# Schema version: 20110420185439
#
# Table name: lesson_screens
#
#  id        :integer(4)      not null, primary key
#  lesson_id :integer(4)
#  content   :text
#  sequence  :integer(4)
#

class LessonScreen < ActiveRecord::Base
	belongs_to	:lesson
	has_attached :content_file
end
