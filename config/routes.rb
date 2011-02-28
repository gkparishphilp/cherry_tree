CherryTree::Application.routes.draw do

	root :to => "site#index"
	
	resources :articles do
		resources :comments
	end
	
	resources :awards do
		get 'admin', :on => :collection
		get 'unlock', :on => :member
		get 'earned', :on => :collection
		get 'set', :on => :collection
	end
	
	resources :blog do
		get	:admin, :on => :collection
	end
	
	resources :checkins do
		get 'approve', :on => :member
	end
	
	resources :children do
		get 'login', :on => :collection
		get 'home', :on => :collection
		get 'profile', :on => :member
		resources :objective_assignments
		resources :award_assignments
		resources :journal_entries do
			resources :comments
			get 'stickers', :on => :member
		end
	end

	resources :contacts do
		get 'admin', :on  => :collection
	end
	
	resources :forums do
		resources :topics do
			resources :posts
		end
	end
	
	resources :games
	
	resources :merches
	
	resources :notes do
		get 'archive', :on => :collection
	end
	
	resources :objectives 
	
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
	
	resources :relations
	
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
	
	resources :static_pages do
		get 'admin', :on => :collection
	end
	
	resources :stickings do
		get 'update_pos', :on => :member
		get 'update_width', :on => :member
	end
	
	resources  :users do
		post 'collect_email', :on => :collection
		get 'resend', :on => :member
		get 'settings', :on => :collection
		get 'home', :on => :collection
	end
	
	resources :weekly_approvals
	
	resources :wishlist_items
	
	match '/admin/' => 'admin#index', :as => :admin_index

	match '/blog/archive/(:year/(:month))', :to => 'blog#index'
	
	match '/forgot' => 'users#forgot_password', :as => 'forgot'
	
	match '/home' => 'users#home', :as => 'home'
	
	match '/logout' => 'sessions#destroy', :as => 'logout'
	match '/login' => 'sessions#new', :as => 'login'
	match '/register' => 'sessions#register', :as => 'register'
	match '/reset' => 'users#reset_password', :as => 'reset'
	match '/activate/:token' => 'users#activate', :as => 'activate'
	match '/resend' => 'users#resend', :as => 'resend'
	match '/amazon' => 'awards#search_amazon', :as => 'amazon'
	
	match "/:permalink", :to => 'static_pages#show'
	
	
	
end
