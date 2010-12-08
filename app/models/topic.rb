class Topic < Post
	
	validates_presence_of	:title
	validates_presence_of	:content, :message => "You have to have something to say to post a topic :)"
	
	belongs_to  :forum
	belongs_to  :user
	has_many    :posts

	has_many :raw_stats, :as => :statable

	has_friendly_id :title, :use_slug => :true
	acts_as_followed
	gets_activities

	scope :recent, lambda { |*args|
		limit( args.first || 5 )
		order( 'created_at desc' )
	}

end