class BlogController < ApplicationController
	# should just show and index blogs.  Used to display Articles so we can use /blog paths instead of /articles paths
	before_filter	:require_admin_or_contributor, :only => :admin
	before_filter	:get_sidebar_data
	helper_method	:sort_column, :sort_dir
	# caches_page :show

	def admin
		@articles = Article.search( params[:q] ).order( sort_column + " " + sort_dir ).page( params[:page] )
	end
	
	
	
	def index
		if @tag = params[:tag]
            @articles = Article.tagged_with( @tag ).published.order( "publish_at desc" ).page( params[:page] )
		elsif @topic = params[:topic]
			@articles = Article.tagged_with( @topic ).published.order( "publish_at desc" ).page( params[:page] )
		elsif ( @month = params[:month] ) && ( @year = params[:year] )
			@articles = Article.month_year( params[:month], params[:year] ).published.order( "publish_at desc" ).page( params[:page] )
		elsif @year = params[:year]
			@articles = Article.year( params[:year] ).published.order( "publish_at desc" ).page( params[:page] )
		else
			@articles = Article.published.order( "publish_at desc" ).page( params[:page] )
		end
	end


	def show
		@article = Article.find params[:id]
		
		@title = @article.title
		@description = @article.excerpt
		
		@comment = Comment.new
		@commentable = @article
		
	end

	def destroy
		@article = Article.find params[:id]
		@article.destroy
		pop_flash 'Article was successfully deleted.'
		redirect_to :back
	end

private

	def get_sidebar_data
		@topics=[]
		@topics = Article.topic_counts.sort do |a, b|
			a.name <=> b.name
		end
		@recent_posts = Article.recent.published[0..9]
		@archives = Article.find_by_sql( "select month(publish_at) as month, year(publish_at) as year from articles  group by month(publish_at) " )
	end
	
	def sort_column
		Article.column_names.include?( params[:sort] ) ? params[:sort] : 'publish_at'
	end
	
	def sort_dir
		%w[ asc desc ].include?( params[:dir] ) ? params[:dir] : 'desc'
	end


	
end
