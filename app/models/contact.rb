# == Schema Information
# Schema version: 20101209043322
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  site_id    :integer(4)
#  user_id    :integer(4)
#  subject    :string(255)
#  ip         :string(255)
#  crash_id   :integer(4)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
	belongs_to :user
	attr_accessor :email
end
