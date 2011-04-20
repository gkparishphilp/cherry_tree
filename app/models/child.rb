# == Schema Information
# Schema version: 20110420185439
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  type                      :string(255)
#  site_id                   :integer(4)
#  registered_by_id          :integer(4)
#  email                     :string(255)
#  name                      :string(255)
#  display_name              :string(255)
#  score                     :integer(4)      default(0)
#  birthday                  :datetime
#  gender                    :string(255)
#  points_earned             :integer(4)      default(100)
#  point_balance             :integer(4)      default(100)
#  level                     :integer(4)      default(0)
#  website_name              :string(255)
#  website_url               :string(255)
#  bio                       :text
#  hashed_password           :string(255)
#  salt                      :string(255)
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  activation_code           :string(255)
#  activated_at              :datetime
#  status                    :string(255)     default("first")
#  cached_slug               :string(255)
#  orig_ip                   :string(255)
#  last_ip                   :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

class Child < User
	
	after_create	:setup_defaults
	
	# for the child/create form -- may just switch to form_tag at some point....
	attr_accessor :role, :nick, :welcome_message
	
	private
	
	def setup_defaults
		# Only doing this as a shitty hack because kids need default
		self.journals.create :name => 'Default'
		self.wishlists.create :name => 'Default'
	end
	
end
