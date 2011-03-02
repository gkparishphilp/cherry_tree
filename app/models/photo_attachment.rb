# == Schema Information
# Schema version: 20110228224652
#
# Table name: photo_attachments
#
#  id              :integer(4)      not null, primary key
#  photo_id        :integer(4)
#  attachable_id   :integer(4)
#  attachable_type :string(255)
#  top             :integer(4)      default(0)
#  left            :integer(4)      default(0)
#  width           :integer(4)      default(64)
#  frame_style     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class PhotoAttachment < ActiveRecord::Base

	belongs_to	:photo
	belongs_to	:attachable
	
end
