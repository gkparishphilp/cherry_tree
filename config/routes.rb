Seedz::Application.routes.draw do
	root :to => "site#index"
	
	
	resources :sessions do
		collection do
			get 'pending'
			get 'register'
			post 'go_facebook'
			post 'go_site_facebook'
			get 'ret_facebook'
			get 'ret_site_facebook'
			post 'go_twitter'
			post 'go_site_twitter'
			get 'ret_twitter'
			get 'ret_site_twitter'
		end
	end
	
	resources  :users do
		collection do
			post 'update_password'
		end
		member do
			post 'update_avatar'
		end
		get 'resend', :on => :member
	end
	
	

	match '/blog/archive/(:year/(:month))', :to => 'blog#index'
	
	match '/forgot' => 'users#forgot_password', :as => 'forgot'
	match '/logout' => 'sessions#destroy', :as => 'logout'
	match '/login' => 'sessions#new', :as => 'login'
	match '/register' => 'sessions#register', :as => 'register'
	match '/reset' => 'users#reset_password', :as => 'reset'
	
	
	
	match "/:permalink", :to => 'static_pages#show'
	
	
	
end
