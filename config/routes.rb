Seedz::Application.routes.draw do

	root :to => "site#index"
	
	resources :articles do
		resources :comments
	end
	
	resources :blog
	
	resources :checkins do
		get 'approve', :on => :member
	end
	
	resources :children do
		get 'login', :on => :collection
	end
	
	resources :forums do
		resources :topics do
			resources :posts
		end
	end
	
	resources :games
	
	resources :messages
	
	resources :objectives
	
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
	
	resources :quizzes do
		get 'admin', :on => :collection
		get 'inspect', :on => :member
		get 'recap', :on => :member
		resources :questions do
			get 'admin', :on => :collection
			post 'answer', :on => :member
			resources :answers do
				get 'admin', :on => :collection
			end
		end
	end
	
	
	resources :unlockables do
		get 'admin', :on => :collection
		get 'unlock', :on => :member
	end
	
	resources  :users do
		get 'resend', :on => :member
	end
	
	resources :relations
	

	match '/blog/archive/(:year/(:month))', :to => 'blog#index'
	
	match '/forgot' => 'users#forgot_password', :as => 'forgot'
	match '/logout' => 'sessions#destroy', :as => 'logout'
	match '/login' => 'sessions#new', :as => 'login'
	match '/register' => 'sessions#register', :as => 'register'
	match '/reset' => 'users#reset_password', :as => 'reset'
	match '/activate/:token' => 'users#activate', :as => 'activate'
	match '/resend' => 'users#resend', :as => 'resend'
	match '/amazon' => 'unlockables#search_amazon', :as => 'amazon'
	
	match "/:permalink", :to => 'static_pages#show'
	
	
	
end
