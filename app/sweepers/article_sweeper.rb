class ArticleSweeper < ActionController::Caching::Sweeper
	observe Article

	def after_create(article)
		expire_page(:controller => 'site', :action => 'index')
		expire_page(:controller => 'blog', :action => 'show')
	end
	
	def after_update(article)
		expire_page(:controller => 'site', :action => 'index')
		expire_page(:controller => 'blog', :action => 'show')
	end
	
	def after_destroy
		expire_page(:controller => 'site', :action => 'index')
		expire_page(:controller => 'blog', :action => 'show')
	end
end