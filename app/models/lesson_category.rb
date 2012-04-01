class LessonCategory < ActiveRecord::Base
	has_many	:lessons
end