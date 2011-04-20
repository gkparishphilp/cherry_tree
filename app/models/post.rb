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
