CherryTree::Application.routes.draw do

	root :to => "site#index"
	
	resources :activities do
		resources :comments
	end
	
	resources :articles do
		resources :comments
	end
	
	resources :awards do
		get 'admin', :on => :collection
		get 'unlock', :on => :member
		get 'earned', :on => :collection
		get 'set', :on => :collection
		get 'print', :on => :member
	end
	
	resources :blog do
		get	:admin, :on => :collection
	end
	
	resources :checkins 
	
	resources :lessons do
		resources :screens
	end
	
	resources :children do
		get 'login', :on => :collection
		get 'home', :on => :collection
		get 'profile', :on => :member
		
		resources :approvals

		resources :objective_assignments
		resources :award_assignments do
			post 'amzn', :on => :collection
		end
		resources :lesson_assignments
		resources :lessons
		
		resources :journal_entries do
			resources :comments
			get 'customize', :on => :member
		end
		resources :invitations
		
		resources :supporters do
			get 'disable', :on => :collection
			get 'enable', :on => :collection
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
	
	resources :guides
	
	resources :invitations

	resources :merches
	
	resources :store
	
	resources :notes do
		get 'archive', :on => :collection
		get 'customize', :on => :member
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
			get 'register_invitee'
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
	
	resources :page_elements do
		get 'update_pos', :on => :member
		get 'update_width', :on => :member
	end
	
	resources  :users do
		post 'collect_email', :on => :collection
		get 'resend', :on => :member
		get 'settings', :on => :collection
		get 'home', :on => :collection
		post 'invite', :on => :collection
		resources :photos
	end
	
	resources :weekly_approvals
	
	resources :wishlist_items
	
	match '/update_page/:obj_type/:obj_id', :to => 'page_elements#updater'
	
	# for award_assignments ajax
	match 'activate/award/:award_id/for/:child_id', :to => 'award_assignments#activate'
	match 'deactivate/award/assignment/:assignment_id/for/:child_id', :to => 'award_assignments#deactivate'
	match 'update/award/assignment/:assignment_id/for/:child_id', :to => 'award_assignments#update'
	
	# for objective_assignments ajax
	match 'activate/objective/:objective_id/for/:child_id', :to => 'objective_assignments#activate'
	match 'deactivate/objective/assignment/:assignment_id/for/:child_id', :to => 'objective_assignments#deactivate'
	match 'update/objective/assignment/:assignment_id/for/:child_id', :to => 'objective_assignments#update'

	match 'requested/objective/:objective_id/for/:child_id', :to => 'objective_assignments#requested'
	match 'unrequested/objective/assignment/:assignment_id/for/:child_id', :to => 'objective_assignments#unrequested'
	
	match 'require_confirmation/assignment/:assignment_id/for/:child_id', :to => 'objective_assignments#require_confirmation'
	match 'remove_confirmation/assignment/:assignment_id/for/:child_id',  :to => 'objective_assignments#remove_confirmation'
	
	match 'check_name/:name', :to => 'users#check_name'
	
	match '/admin/' => 'admin#index', :as => :admin_index

	match '/blog/archive/(:year/(:month))', :to => 'blog#index'
	
	match '/forgot' => 'users#forgot_password', :as => 'forgot'
	
	match '/home' => 'users#home', :as => 'home'
	match '/invitation/:code' => 'invitations#accept_invite', :as => 'invitation'
	match '/logout' => 'sessions#destroy', :as => 'logout'
	match '/login' => 'sessions#new', :as => 'login'
	match '/register' => 'sessions#register', :as => 'register'
	match '/reset' => 'users#reset_password', :as => 'reset'
	match '/activate/:token' => 'users#activate', :as => 'activate'
	match '/resend' => 'users#resend', :as => 'resend'
	match '/amazon/(:index/(:term))' => 'amazon#search', :as => 'amazon'
	match "/:permalink", :to => 'static_pages#show'
	
	
	
end
