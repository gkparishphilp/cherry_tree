
class LessonViewing < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:lesson
	belongs_to	:lesson_screen
end
