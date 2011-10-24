class TopicsController < ApplicationController
	before_filter :require_login, :except => [:index, :show]
	before_filter :get_parent
	layout			:set_layout

	def index
		@topics = @forum.topics.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
		@topic = Topic.new
		set_meta @forum.title, @forum.description
	end

	def show
		@topic = Topic.find(params[:id])
		@forum = @topic.forum
		@posts = @topic.posts.paginate :page => params[:page], :order => 'created_at ASC', :per_page => 10
		@post = Post.new
		
		#rs = @topic.raw_stats.create :name => 'view', :ip => request.ip
	end

	def edit
		@topic = Topic.find params[:id]
		 require_user_can_manage( @topic )
	end

	def update
		@topic = Topic.find params[:id]
		 require_user_can_manage( @topic )

		if @topic.update_attributes(params[:topic])
			pop_flash 'Topic was successfully updated.'
			redirect_to forum_topic_path( @forum, @topic )
		else
			pop_flash 'Topic not saved', :error, @topic
			redirect_to edit_forum_topic_path( @forum, @topic )
		end
	end

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(params[:topic])
		@topic.user = @current_user
		@topic.ip = request.ip
		if ( @forum.topics << @topic )
			flash[:notice] = "Topic added"
			#@current_user.did_post_in_the_forums @topic
			redirect_to forum_topics_path( @topic.forum )
		else
			pop_flash = "Topic not saved", :error, @topic
			redirect_to new_forum_topic_path( @topic.forum )
		end
	end
	
private

	def get_parent
		@forum = Forum.find params[:forum_id]
	end 
	
	
	def get_sidebar_data
		# TODO
	end
	
	def set_layout
		@author ? "authors" : "application"
	end
	
	
end
