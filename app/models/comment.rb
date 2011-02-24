# == Schema Information
# Schema version: 20110210211558
#
# Table name: comments
#
#  id                  :integer(4)      not null, primary key
#  site_id             :integer(4)
#  user_id             :integer(4)
#  commentable_id      :integer(4)
#  commentable_type    :string(255)
#  reply_to_comment_id :integer(4)
#  ip                  :string(255)
#  content             :text
#  created_at          :datetime
#  updated_at          :datetime
#

class Comment < ActiveRecord::Base
    
	belongs_to  :commentable, :polymorphic => :true
	belongs_to  :user

	validates_presence_of :content, :message => "You really should have to have something to say to post a comment :)"
	
	acts_as_followed
                

end
