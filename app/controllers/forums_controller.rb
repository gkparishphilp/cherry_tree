class ForumsController < ApplicationController
	before_filter	:get_sidebar_data
	layout			:set_layout
	
	def admin
		@forums = @owner.forums.all
	end
	
	def index
		@forums = Forum.all.paginate :page => params[:page], :order => 'id ASC', :per_page => 10
	end

	def show
		@forum = Forum.find params[:id] 
		set_meta @forum.title, @forum.description
	end

	def new
		@forum = Forum.new
		render :layout => '3col'
	end

	def edit
		@forum = Forum.find params[:id] 
		unless author_owns( @forum )
			redirect_to root_path
			return false
		end
		render :layout => '3col'
	end

	def create
		@forum = Forum.new params[:forum]
		
		if @owner.forums << @forum
			pop_flash 'Forum was successfully created.'
			redirect_to admin_forums_path 
		else
			pop_flash 'Oooops, Forum not saved... ', :error, @forum
			render :action => "new" 
		end
	end

	def update
		@forum = Forum.find params[:id] 
		unless author_owns( @forum )
			redirect_to root_path
			return false
		end
		if @forum.update_attributes params[:forum]
			pop_flash 'Forum was successfully updated.'
			redirect_to admin_forums_path
		else
			pop_flash 'Oooops, Forum not updated... ', :error, @forum
			render :action => "edit"
		end
	end

	def destroy
		@forum = Forum.find params[:id] 
		@forum.destroy

		redirect_to admin_forums_path
	end
	
private

	def get_sidebar_data
		# TODO
	end
	
	def set_layout
		@author ? "authors" : "application"
	end
	
end
