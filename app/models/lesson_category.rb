
class LessonCategory < Category

	has_many	:lessons
	
	has_attached	:avatar

end