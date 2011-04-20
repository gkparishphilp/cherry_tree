module UserApp
	# Misc App-Specific User Methods
	
	def best_item
		self.objective_assignments.active.first
	end
	
	
	def is_child?
		return self.type == 'Child'
	end
	
	alias :child? :is_child?
	
	def relation_to( user )
		self.relationships.find_by_related_user_id( user.id ).role
	end
	
	def nickname( user=nil )
		# nickname is defined in the relationship between users -- what one user calls another
		# if called without a user for the relationship, just returns the display_name
		if user.present?
			relationship = self.relationships.find_by_related_user_id( user.id )
			return relationship.nickname if relationship
		end
			
		self.display_name
	end
	
	def relate_to( user, args={} )
		relationship = self.relationships.find_or_initialize_by_related_user_id( user.id )
		if args[:as].present? 
			role = args[:as]
		elsif relationship.role.present?
			role = relationship.role
		else
			role = 'relative'
		end
		if args[:nickname].present?
			nickname = args[:nickname]
		elsif relationship.nickname.present?
			nickname = relationship.nickname
		else
			nickname = self.display_name
		end
		relationship.attributes = { :role => role, :nickname => nickname }
		relationship.save
		return relationship, relationship.symmetric_relationship
	end
	
	def write_note( args={} )
		if note = self.sent_notes.create( :subject => args[:subject], :content => args[:content] )
			note.deliver_to( args[:to] )
		end
	end
	

	def get_unchecked_assignments
		assignments = self.objective_assignments.unchecked_for_today + self.objective_assignments.never_checked
	end

	
	def earn_points_for( obj, points=nil )
		# take an event object (message, check-in, activity, gam, quiz, etc.), create an earning transaction 
		# and add points to the user's point_balance and point_total
		points = obj.point_value if points.nil?
		self.point_earnings.create :earned_for_id => obj.id, :earned_for_type => obj.class.name, :points => points
		self.update_attributes :points_earned => ( self.points_earned + points ), :point_balance => ( self.point_balance + points )
	end
	
	
	
	def can_unlock?( reward )
		if reward.is_a?( Award )
			assignment = reward.award_assignments.find_by_user_id( self.id )
			return false if assignment.nil?
			cost = assignment.point_cost
		else
			cost = reward.point_cost
		end
		return self.point_balance >= cost # && self.level >= reward.level
	end
	
	def unlock( reward )
		if reward.is_a?( Award )
			assignment = reward.award_assignments.find_by_user_id( self.id )
			return false, "You can't unlock this yet" if assignment.nil?
			cost = assignment.point_cost
		else
			cost = reward.point_cost
		end
		return false, "You can't unlock this yet" unless self.can_unlock?( reward )
		self.ownings.create :ownable_id => reward.id, :ownable_type => reward.class.name
		self.update_attributes :point_balance => self.point_balance - cost
		return true, "Unlocked!"
	end
	
	def owns?( item )
		self.ownings.find_by_ownable_id_and_ownable_type( item.id, item.class.name )
	end
	

	
end