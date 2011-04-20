# == Schema Information
# Schema version: 20110420185439
#
# Table name: lesson_materials
#
#  id            :integer(4)      not null, primary key
#  lesson_id     :integer(4)
#  content       :text
#  material_type :string(255)
#

class LessonScreen < ActiveRecord::Base
	belongs_to	:lesson
	has_attached :content_file
end
