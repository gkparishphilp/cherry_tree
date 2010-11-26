class Follow < ActiveRecord::Base
	extend FollowIt::FollowLib

	# NOTE: Follows belong to the "followable" interface, and also to followers
	belongs_to :followed, :polymorphic => true
	belongs_to :follower, :polymorphic => true

	scope :for_follower, lambda { |follower| where( ["follower_id = ? AND follower_type = ?", 
									follower.id, parent_class_name( follower )] ) }
	scope :for_followed, lambda { |followed| where( ["followed_id = ? AND followed_type = ?", 
										followed.id, parent_class_name( followed )] ) }
	scope :for_follower_type, lambda { |follower_type| where( "follower_type = ?", follower_type ) }
	scope :for_followed_type, lambda { |followed_type| where( "followed_type = ?", followed_type ) }
	scope :recent, lambda { |since| where( ["created_at > ?", ( since || 2.weeks.ago ).to_s( :db )] ) }
	scope :descending, order( "follows.created_at DESC" )
	scope :active, where( :status => 'active' )
	scope :deleted, where( :status => 'deleted' )

	def active?
		self.status == 'active'
	end
	
	def delete!
		self.update_attribute( :status => 'deleted' )
	end
  
end