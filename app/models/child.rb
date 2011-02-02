# == Schema Information
# Schema version: 20101209043322
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
#  points_earned             :integer(4)      default(0)
#  points_balance            :integer(4)      default(0)
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
#  invitation_code           :string(255)
#  status                    :string(255)     default("first")
#  cached_slug               :string(255)
#  orig_ip                   :string(255)
#  last_ip                   :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

class Child < User
	
	has_many	:relations
	has_many	:supporters, :through => :relations, :class_name => 'User', :foreign_key => :user_id, :source => :user
	has_many	:parents, :through => :relations, :class_name => 'User', :foreign_key => :user_id, :source => :user,
				:conditions => "role IN ( 'mother', 'father' )"
	
	
	does_activities
	
	attr_accessor :role, :welcome_message
	
end
