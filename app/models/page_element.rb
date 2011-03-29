# == Schema Information
# Schema version: 20110228224652
#
# Table name: page_elements
#
#  id         :integer(4)      not null, primary key
#  page_id    :integer(4)
#  page_type  :string(255)
#  photo_id   :integer(4)
#  sticker_id :integer(4)
#  type       :string(255)
#  top        :integer(4)      default(0)
#  left       :integer(4)      default(0)
#  width      :integer(4)      default(100)
#  height     :integer(4)      default(24)
#  copy       :text
#  caption    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class PageElement < ActiveRecord::Base
	belongs_to	:page, :polymorphic => true
	belongs_to	:sticker
	belongs_to	:photo
	
	def content
		if self.sticker.present?
			return "<img src='#{self.sticker.avatar.location}' width='#{self.width}' />".html_safe
		elsif self.photo.present?
			return "<img src='#{self.photo.avatar.location}' width='#{self.width}' />".html_safe
		end
	end
end
