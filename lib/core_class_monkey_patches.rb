# Include Monkey Patches to Ruby's core classes here
# Better Document this Shit!!!

class Numeric
	# For any Ruby number class, these functions round up or down to the nearest
	# unit passed in.  E.g. 116.roundup( 10 ) == 120
	def roundup( nearest=10 )
		self % nearest == 0 ? self : self + nearest - ( self % nearest )
	end
	
	def rounddown( nearest=10 )
		self % nearest == 0 ? self : self - ( self % nearest )
	end
	
	def roundnearest( nearest=10 )
		up = roundup( nearest )
		down = rounddown( nearest )
		# return the result that yields the smaller difference ;-)
		( up - self ) <= ( self - down ) ? up : down
	end
	
	
end 