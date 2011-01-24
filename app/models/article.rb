# == Schema Information
# Schema version: 20101209043322
#
# Table name: articles
#
#  id               :integer(4)      not null, primary key
#  owner_id         :integer(4)
#  owner_type       :string(255)
#  title            :string(255)
#  excerpt          :string(255)
#  snip_at          :integer(4)
#  view_count       :integer(4)      default(0)
#  content          :text
#  status           :string(255)     default("publish")
#  comments_allowed :boolean(1)
#  publish_at       :datetime
#  article_type     :string(255)
#  cached_slug      :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Article < ActiveRecord::Base
	before_save :set_publish_at
	
	belongs_to :owner, :polymorphic => true
	
	has_many	:comments, :as => :commentable
    
	has_friendly_id :title, :use_slug => :true
	acts_as_taggable_on	:topics
	acts_as_taggable_on	:keywords
	
	acts_as_followed
	gets_activities
	
	searchable_on [ :title ]
	
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
	
	def set_excerpt
		unless self.excerpt.blank?
			excerpt = self.content.gsub!(%r{</?[^>]+?>}, '') #remove html tags?		
			self.update_attributes :excerpt => excerpt[0..200]
		end
	end
	
	def set_publish_at
		self.publish_at = Time.now unless self.publish_at
	end
	
end
