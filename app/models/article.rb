class Article < ActiveRecord::Base
	before_save :set_publish_at
	
	belongs_to :owner, :polymorphic => true
	
	has_many	:comments, :as => :commentable
    
	has_friendly_id :title, :use_slug => :true
	#acts_as_taggable_on	:topics
	#acts_as_taggable_on	:keywords
	acts_as_followed
	gets_activities
	
	scope :published, where( "publish_at <= ? and status = 'publish'", Time.now )
		
	scope :recent, lambda { |*args|
		limit( args.first || 5 )
		order( 'publish_at desc' )
	}
	
	scope :dated_between, lambda { |*args| 
		where( "publish_at between ? and ?", (args.first || 1.day.ago), (args.second || Time.now) ) 
	} 
	
	scope :month_year, lambda { |*args| 
		where( " month(publish_at) = ? and year(publish_at) = ?", (args.first || Time.now.month), (args.second || Time.now.year) )
		order( 'publish_at desc' )
	}
	
	scope :year, lambda { |*args| 
		where( " year(publish_at) = ?", (args.first || Time.now.year) )
		order( 'publish_at desc' )
	}
	
	
	def related_articles
		return [] if self.keywords.empty?
		articles = Article.published.tagged_with( self.keywords, :any => true ).all
		articles.delete( self )
		return articles
	end
	
	def comments_allowed?
		return comments_allowed
	end
	
	def published?
		self.publish_at <= Time.now && self.status == 'publish'
	end
	
private

	def set_publish_at
		self.publish_at = Time.now unless self.publish_at
	end
	
end
