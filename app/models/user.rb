
class User < ActiveRecord::Base
	
	# App -Specific Modules
	#include UserAchievements
	
	#include UserApp  # misc stuff not broken into module yet

  

	
	# Relations   	--------------------------------------

	# Testing robust relationships
	has_many	:relationships
	has_many	:related_users, :through => :relationships
	has_many	:relatives, :through => :relationships, 
							:source => :related_user, 
							:conditions => "role IN ( 'son', 'daughter', 'mother', 'father', 'guardian', 'brother',
							'sister', 'aunt', 'uncle', 'niece', 'nephew','cousin', 'grandmother', 'grandfather',
							'grandson', 'granddaughter', 'relative', 'stepmother', 'stepfather' ) and relationships.status = 'active'"
	has_many	:children, :through => :relationships, 
							:foreign_key => :related_user_id, 
							:class_name => 'Child', 
							:source => :related_user, 
							:conditions => "role IN ( 'mother', 'father', 'guardian' ) and relationships.status = 'active'"
	has_many	:supported_children, :through => :relationships, 
									:foreign_key => :related_user_id, 
									:class_name => 'Child', 
									:source => :related_user, 
									:conditions => "role NOT IN ( 'mother', 'father', 'guardian' ) and relationships.status = 'active'"

	# User is the subject of the sentence.  User(child) has parents and he/she is their 'son/daughter'
	has_many	:parents, :through => :relationships,
						:source => :related_user, 
						:conditions => "role IN ( 'son', 'daughter', 'ward', 'client') and relationships.status = 'active'"

	has_many	:sent_notes, :foreign_key => :sender_id, :class_name => 'Note'
	
	has_many	:note_deliveries, :foreign_key => :recipient_id
	has_many	:received_notes, :through => :note_deliveries, :source => :note
		# I'm also going to alias that relationship because it's easier to type and understand
	has_many	:notes, :through => :note_deliveries, :source => :note



		# for kids, the assignemnts they have
	has_many	:objective_assignments
	has_many	:objectives, :through => :objective_assignments
	
	def active_assigned_objectives
		self.objective_assignments.where( "objective_assignments.status = 'active'" ).collect{ |asgn| asgn.objective }
	end

	def requested_objectives
		self.objective_assignments.where( "objective_assignments.status = 'requested'" ).collect{ |asgn| asgn.objective }
	end
	
	has_many	:checkins
	
		# for adults, objectives and assignments they've made
	has_many	:created_objective_assignments, :class_name => 'ObjectiveAssignment', :foreign_key => :creator_id
	has_many	:created_objectives, :class_name => 'Objective', :foreign_key => :creator_id


	has_many	:point_earnings
	has_many	:point_spendings

	has_many	:award_assignments
	# Awards that are available to the child
	has_many	:assigned_awards, :through => :award_assignments, :source => :award
	
	
	def active_assigned_awards
		self.award_assignments.where( "status = 'active'" ).collect{ |assignment| assignment.award }
		#self.assigned_awards.joins( :award_assignments ).where( "status = 'active'" )
	end
	


	
		# for adults, awards and assignments they've made
	has_many	:created_award_assignments, :class_name => 'AwardAssignment', :foreign_key => :creator_id
	has_many	:created_awards, :class_name => 'Award', :foreign_key => :creator_id
	
	has_many	:achievement_earnings
	has_many	:achievements, :through => :achievement_earnings
	
	has_many	:lesson_assignments
	has_many	:lessons, :through => :lesson_assignments, :conditions => "status = 'active'"
	has_many	:lesson_viewings

	has_many	:ownings
	# putting these here because they act like relations, but you can't have a :through relation on a polymorphic object
	def awards
		self.ownings.awards
	end
	
	def unlockables
		self.ownings.unlockables
	end
	
	def stickers
		self.ownings.stickers
	end
	
	has_many	:created_awards, :class_name => 'Award', :as => :creator

	has_many	:weekly_approvals, :foreign_key => :creator_id
	has_many	:approvals, :foreign_key  => :creator_id
	
	has_many	:journals
	has_many	:journal_entries, :through => :journals
	
	has_many	:photo_albums
	has_many	:photos, :through => :photo_albums
	
	has_many	:quizzings
	has_many	:quiz_assignments

	has_many	:invitations
	has_many	:sent_invitations, :class_name => 'Invitation', :foreign_key => :creator_id
	


	# Instance Methods	------------------------------------
	# For sessions / Validations, etc..
		

	
	def pronoun_gender_possessive
		return 'their' if self.gender.blank?
		self.gender == 'male' ? 'his' : 'her'
	end
	
	def pronoun_gender_subject
		return 'they' if self.gender.blank?
		self.gender == 'male' ? 'he' : 'she'
	end
	
	def pronoun_gender_object
		return 'them' if self.gender.blank?
		self.gender == 'male' ? 'him' : 'her'
	end
	
	
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
		return true, "Congratulations!"
	end
	
	def owns?( item )
		self.ownings.find_by_ownable_id_and_ownable_type( item.id, item.class.name )
	end
	
	def point_earnings_since(time)
		earned = self.point_earnings.for_assignments.dated_between(time.getutc,Time.now.getutc)
		academics = 0
		behavior = 0
		health = 0
		social = 0
		
		for earning in earned
			case earning.earned_for.objective.objective_category.try(:name)
			when 'Academics'
				academics += earning.points
			when 'Health'
				health += earning.points
			when 'Behavior'
				behavior += earning.points
			when 'Social'
				social += earning.points
			end 
		end
		
		points = {'Academics' => academics, 'Health' => health, 'Behavior'=> behavior, 'Social'=> social}
		
		return points
		
	end
	

	

end
