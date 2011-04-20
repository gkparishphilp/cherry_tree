# == Schema Information
# Schema version: 20110420185439
#
# Table name: posts
#
#  id               :integer(4)      not null, primary key
#  forum_id         :integer(4)
#  topic_id         :integer(4)
#  reply_to_post_id :integer(4)
#  user_id          :integer(4)
#  title            :string(255)
#  content          :text
#  view_count       :integer(4)      default(0)
#  ip               :string(255)
#  type             :string(255)
#  cached_slug      :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Topic < Post
	
	validates_presence_of	:title
	validates_presence_of	:content, :message => "You have to have something to say to post a topic :)"
	
	belongs_to  :forum
	belongs_to  :user
	has_many    :posts

	has_many :raw_stats, :as => :statable

	has_friendly_id :title, :use_slug => :true
	acts_as_followed


	scope :recent, lambda { |*args|
		limit( args.first || 5 )
		order( 'created_at desc' )
	}

end
