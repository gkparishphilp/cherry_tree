# == Schema Information
# Schema version: 20110420185439
#
# Table name: photos
#
#  id             :integer(4)      not null, primary key
#  photo_album_id :integer(4)
#  title          :string(255)
#  caption        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Photo < ActiveRecord::Base

	belongs_to	:photo_album
	has_many	:photo_attachments
	
	has_attached :avatar, :formats => ['jpg', 'gif', 'png'], :process => { :resize => {
				:full => "800",
				:profile  => "200",
				:thumb => "64",
				:tiny => "20"
				}}
	
	acts_as_taggable_on	:tags
end
