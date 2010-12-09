# == Schema Information
# Schema version: 20101209043322
#
# Table name: forums
#
#  id           :integer(4)      not null, primary key
#  owner_id     :integer(4)
#  owner_type   :string(255)
#  title        :string(255)
#  availability :string(255)
#  description  :string(255)
#  cached_slug  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Forum < ActiveRecord::Base
	
	belongs_to	:owner, :polymorphic => :true
	has_many	:topics
	has_many	:posts
    
	has_friendly_id :title, :use_slug => :true
	
end
