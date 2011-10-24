class PostsController < ApplicationController
	before_filter :require_login
	before_filter :get_parent
	
	def new
		@post = Post.new
		@posts = @topic.posts.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
	end
	
	def edit
		@post = Post.find params[:id]
		 require_user_can_manage( @post )
	end
	
	def update
		@post = Post.find params[:id] 
		 require_user_can_manage( @post )

		if @post.update_attributes(params[:post])
			pop_flash 'Post was successfully updated.'
			redirect_to  forum_topic_path( @topic.forum, @topic )
		else
			pop_flash 'Post not saved. ', :error, @post
			
			redirect_to edit_forum_topic_path( @topic.forum, @topic )
			
		end
	end
	
	def create
		@post = Post.new(params[:post])
		@post.user = @current_user
		@post.ip = request.ip
		if  @topic.posts << @post  
			@forum.posts << @post
			#@current_user.did_post_in_the_forums @post
			pop_flash "Post added"
			redirect_to forum_topic_path( @forum, @topic)
		else
 			pop_flash 'Post not saved. ', :error, @post
			redirect_to forum_topic_path( @topic.forum, @topic )
		end
	end
	
private
	
	def get_parent
		@forum = Forum.find params[:forum_id] if params[:forum_id]
		@topic = Topic.find params[:topic_id] if params[:topic_id]
	end 
end