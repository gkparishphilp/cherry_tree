# == Schema Information
# Schema version: 20101209043322
#
# Table name: twitter_accounts
#
#  id         :integer(4)      not null, primary key
#  owner_id   :integer(4)
#  owner_type :string(255)
#  twit_id    :string(255)
#  token      :string(255)
#  secret     :string(255)
#  name       :string(255)
#  status     :string(255)     default("active")
#  created_at :datetime
#  updated_at :datetime
#

class TwitterAccount < ActiveRecord::Base

	belongs_to  :owner, :polymorphic => :true
	
	########
	# Twitter Methods to register with Twitter and get a valid client session
	# for posting tweets, retrieving followers, etc., etc.
	def oauth
		@oauth ||= Twitter::OAuth.new( TWITTER_KEY, TWITTER_SECRET )
	end

	def client
		@client ||= begin
			oauth.authorize_from_access( self.token, self.secret )
			Twitter::Base.new( oauth )
		end
	end
	
	def post_feed( message, *url )
		url = url.first
		if url
			chars_left = 136 - url.length
		else
			chars_left = 138
		end
		message = message[0..chars_left] + (message.length > chars_left ? "..." : "")
		message += url if url.present?
		
		tweet = self.client.update( message )
	end

end
