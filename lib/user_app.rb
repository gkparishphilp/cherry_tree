module UserApp
	# Misc App-Specific User Methods
	
	def best_item
		self.objective_assignments.active.first
	end
	
	def most_relevant
		
		#gather up active assignments with no checkins for today
		obj_assignments = self.objective_assignments.active.delete_if{ |assignment| 
			assignment.checkin_in_last?( Time.now.beginning_of_day ) 
		}
		
		#gather up uncompleted lesson assignments
		lesson_assignments = self.lesson_assignments.delete_if{ |assignment|
			assignment.completed_by?( self ) || assignment.offered_today_to?( self )
		}
	
		#This message is actually the partial name in views/users which shows the all done screen
		closing_message = 'done'
		
		# Send back number of assignments for counter
		num_assignments = 0
		num_assignments += obj_assignments.count if obj_assignments.present?
		num_assignments += lesson_assignments.count if lesson_assignments.present?
		
		#Keep falling down the tree until a most relevant item is found or return the closing message
		if obj_assignments.present?
			parent = obj_assignments.first.objective
			return obj_assignments.first, parent, num_assignments
		elsif lesson_assignments.present?
			parent = lesson_assignments.first.lesson
			return lesson_assignments.first, parent, num_assignments
		else
			return closing_message, nil, num_assignments
		end

	end
	
	def is_child?
		return self.type == 'Child'
	end
	
	alias :child? :is_child?
	
	def relation_to( user )
		self.relationships.find_by_related_user_id( user.id ).role
	end

	def unrelate_to( user )
		relation = self.relationships.find_by_related_user_id( user.id )
		symmetric_relation = user.relationships.find_by_related_user_id( self.id )
		relation.update_attributes :status => 'inactive' if relation
		symmetric_relation.update_attributes :status => 'inactive' if symmetric_relation
	end

	def rerelate_to( user )
		relation = self.relationships.find_by_related_user_id( user.id )
		symmetric_relation = user.relationships.find_by_related_user_id( self.id )
		relation.update_attributes :status => 'active'
		symmetric_relation.update_attributes :status => 'active' 
	end
	
	def related_to?( user )
		if relation = self.relationships.find_by_related_user_id( user.id )
			relation.status == 'active' ? (return true) : (return false)
		else
			return false
		end
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
		UserMailer.earned_award( self , reward ).deliver
		return true, "Unlocked!"
	end
	
	def owns?( item )
		self.ownings.find_by_ownable_id_and_ownable_type( item.id, item.class.name )
	end
	
	def point_earnings_since(time)
		earned = self.point_earnings.for_assignments.dated_between(time.getutc,Time.now.getutc)
		academics = 0
		behavior = 0
		health = 0
		hygiene = 0
		
		for earning in earned
			case earning.earned_for.objective.category
			when 'Academics'
				academics += earning.points
			when 'Health'
				health += earning.points
			when 'Behavior'
				behavior += earning.points
			when 'Hygiene'
				hygiene += earning.points
			end 
		end
		
		points = {'Academics' => academics, 'Health' => health, 'Behavior'=> behavior, 'Hygiene'=> hygiene}
		
		return points
		
	end
	
	def monthly_point_earnings
	end

	
end