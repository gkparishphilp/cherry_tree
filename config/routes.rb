CherryTree::Application.routes.draw do
	
	resources :awards do
		get 'admin', :on => :collection
		get 'unlock', :on => :member
		get 'earned', :on => :collection
		get 'set', :on => :collection
		get 'print', :on => :member
	end
	
	resources :checkins 
	
	resources :lessons do
		resources :lesson_screens
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
	
	resources :invitations
	
	resources :notes do
		get 'archive', :on => :collection
		get 'customize', :on => :member
	end
	
	resources :objectives 
	
	resources :quizzes do
		get 'admin', :on => :collection
		get 'inspect', :on => :member
		get 'recap', :on => :member
		resources :quiz_questions do
			get 'admin', :on => :collection
			post 'answer', :on => :member
			resources :quiz_answers do
				get 'admin', :on => :collection
			end
		end
	end
	
	resources :relations
	

	
	resources :weekly_approvals
	
	
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
	

	match '/invitation/:code' => 'invitations#accept_invite', :as => 'invitation'

	match '/amazon/(:index/(:term))' => 'amazon#search', :as => 'amazon'

	
end
