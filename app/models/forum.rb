class Forum < ActiveRecord::Base
	
	belongs_to	:owner, :polymorphic => :true
	has_many	:topics
	has_many	:posts
    
	has_friendly_id :title, :use_slug => :true
	
end