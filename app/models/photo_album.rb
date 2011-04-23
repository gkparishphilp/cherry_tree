# == Schema Information
# Schema version: 20110420185439
#
# Table name: photo_albums
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  title       :string(255)
#  description :text
#  location    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class PhotoAlbum < ActiveRecord::Base
	
	belongs_to	:user
	has_many	:photos
	
end
