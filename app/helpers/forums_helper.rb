module ForumsHelper

	def custom_post_path( forum, topic, post )

		return forum_topic_path( forum, post ) if topic.nil?

		path = forum_topic_path( forum, topic )

		path += "?page=" + topic.posts.last.paginated_page( topic ).to_s + 
					"#post_" + topic.posts.last.id.to_s
		return path
	end
	
	def forum_topics_link( forum )
		forum_topics_path( forum )
	end
	
	def forum_topic_link( topic )
		forum_topic_path( topic.forum, topic )
	end
	
	def forums_link
		forums_path
	end
	
	def new_forum_topic_link( forum )
		new_forum_topic_path( forum )
	end
		
end