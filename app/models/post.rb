class Post < ActiveRecord::Base
	belongs_to  :topic, :class_name => "Topic", :foreign_key => :topic_id
	belongs_to  :forum
	belongs_to  :user
	has_many	:raw_stats, :as => :statable

	validates_presence_of :content, :message => "You have to have something to say to post :)"

	def topic?
		self.type == "Topic"
	end

	def paginated_page( topic, per_page = 10 )
		priors = topic.posts.where( "id < :my_id", { :my_id => self.id } ).order( :id ).count
		page = ( priors / per_page ) + 1
	end


end