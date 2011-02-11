class StaticPageSweeper < ActionController::Caching::Sweeper
	observe StaticPage
	def after_create(static_page)
		expire_page(:controller => 'static_pages', :action => 'show')
	end
	
	def after_update(static_page)
		expire_page(:controller => 'static_pages', :action => 'show')
	end
	
	def after_destroy
		expire_page(:controller => 'static_pages', :action => 'show')
	end
end