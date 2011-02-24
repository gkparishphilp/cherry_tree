# == Schema Information
# Schema version: 20110210211558
#
# Table name: facebook_accounts
#
#  id         :integer(4)      not null, primary key
#  owner_id   :integer(4)
#  owner_type :string(255)
#  name       :string(255)
#  fb_id      :string(255)
#  fb_token   :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FacebookAccount < ActiveRecord::Base
	
	belongs_to  :owner, :polymorphic => :true
	
	def post_feed( message )
		MiniFB.post( self.fb_token, "me", :type => 'feed', :message => message )
	end
end
