module UserAchievements
	# Functionality to make Achievements work
	# also, add any specific methods to encasulate complex achievement requirements logic here
	
	def qualified_for?( achievement )
		# evals the requirements against self.  The result is always a Boolean
		return eval "self.#{achievement.requirements}"
	end
	
	def has_achievement?( achievement )
		self.achievements.include? (achievement )
	end
	
	def award_achievement( achievement )
		self.achievements << achievement unless self.has_achievement?( achievement )
	end
	
	def newly_earned?( achievement )
		return false if self.has_achievement?( achievement )
		if self.qualified_for?( achievement )
			self.award_achievement( achievement )
			return achievement
		end
	end
	
	
end