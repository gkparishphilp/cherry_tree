class CommentsController < ApplicationController
	before_filter   :get_commentable
	
	def new
		@comment = Comment.new
	end

	def edit
		@comment = @commentable.comments.find  params[:id]
		 require_user_can_manage( @comment )
	end

	def create
		
		@comment = Comment.new params[:comment]
		@comment.ip = request.ip
		if @current_user.anonymous?
			user = User.find_by_email( params[:email] )
			@comment.user = user
			if user.nil?
				user = User.new :email => params[:email], :website_name => params[:website_name], :website_url => params[:website_url], :display_name => params[:display_name], :site_id => @current_site.id
				if user.save
					@comment.user = user
				else 
					pop_flash "There was a problem with your comment", :error, user
					if ( @commentable.is_a? Article )
						redirect_to blog_path @commentable
					else
						redirect_to polymorphic_path [ @commentable_parent, @commentable ] 
					end
					return false
				end
			end
		else 
			@comment.user = @current_user
		end
		#need to bypass recaptcha is current_user is logged in or human....
		if @current_user.anonymous? && !@current_user.human?
			if verify_recaptcha( :model => @comment ) && ( @commentable.comments << @comment )
				pop_flash "Thanks for your comment!"
				@comment.user.follow @comment.commentable if params[:subscribe_comments]
				cookies[:human] = { :value => 'true', :expires => 10.minutes.from_now }
			else
				pop_flash "There was a problem with your comment: ", :error, @comment
			end
		elsif ( @commentable.comments << @comment )
			pop_flash "Thanks for your comment!"
			@comment.user.follow @comment.commentable if params[:subscribe_comments]
		else
			pop_flash "There was a problem with your comment: ", :error, @comment
		end

		# redirect_to polymorphic_url @commentable
		# we're going back to the parent resource no matter what...
		# But the site blog is a special case since it uses a different controller
		# from the resource name
		redirect_to :back
		
	end #create

	def update
		@comment = @commentable.comments.find params[:id] 

		 require_user_can_manage( @comment )

		if @comment.update_attributes params[:comment] 
			pop_flash "Comment was successfully updated."
			# see notes on create redirect for why this goes to blog_path rather than polymorphic_url
			redirect_to blog_path @commentable
		else
			pop_flash "There was a problem with your comment: ", :error, @comment
			render :action => :edit
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		pop_flash 'Comment was successfully deleted.'
		redirect_to polymorphic_url @commentable
	end
	
private 

	def get_commentable
		if params[:article_id] 
			@commentable = Article.find( params[:article_id] )
		elsif params[:checkin_id]
			@commentable = Checkin.find( params[:checkin_id] )
		elsif params[:objective_assignemnt_id]
			@commentable = ObjectiveAsignment.find( params[:objcetive_assignment_id] )
		elsif params[:activity_id]
			@commentable = Activity.find( params[:activity_id] )
		end
	end 
	
	

end
