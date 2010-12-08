class BlogController < ApplicationController
	# should just show and index blogs.  Used to display Articles so we can use /blog paths instead of /articles paths

	before_filter	:get_owner, :get_sidebar_data
	layout			:set_layout

	def index
		if @tag = params[:tag]
            @articles = @owner.articles.tagged_with( @tag ).published.paginate :order => "publish_at desc", :page => params[:page], :per_page => 10
		elsif @topic = params[:topic]
			@articles = @owner.articles.tagged_with( @topic ).published.paginate :order => "publish_at desc", :page => params[:page], :per_page => 10
		elsif ( @month = params[:month] ) && ( @year = params[:year] )
			@articles = @owner.articles.month_year( params[:month], params[:year] ).published.paginate :page => params[:page], :per_page => 10
		elsif @year = params[:year]
			@articles = @owner.articles.year( params[:year] ).published.paginate :page => params[:page], :per_page => 10
		else
			@articles = @owner.articles.published.order( 'publish_at desc' ).paginate :page => params[:page], :per_page => 10
		end
	end


	def show
		@article = Article.find params[:id]
		
		set_meta @article.title, @article.content
		
		@comment = Comment.new
		@commentable = @article
		
		@current_user.did_read @article unless @current_user.anonymous?
		
	end


private

	def get_owner
		@owner = @author ? @author : @current_site
	end

	def get_sidebar_data
		@topics = @owner.articles.topic_counts.sort do |a, b|
			a.name <=> b.name
		end
		@recent_posts = @owner.articles.recent.published[0..9]
		@archives = Article.find_by_sql( [ "select month(publish_at) as month, year(publish_at) as year from articles where owner_id = ? and owner_type = ?  group by month(publish_at) ", @owner.id, @owner.class.name ] )
	end
	
	def set_layout
		@author ? "authors" : "application"
	end
	
end
