# == Schema Information
# Schema version: 20110228224652
#
# Table name: awards
#
#  id           :integer(4)      not null, primary key
#  creator_id   :integer(4)
#  creator_type :string(255)
#  name         :string(255)
#  description  :text
#  asin         :string(255)
#  point_cost   :integer(4)
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Award < ActiveRecord::Base
	belongs_to	:creator, :polymorphic => true
	has_many	:ownings, :as => :ownable
	
	has_many	:users, :through => :ownings
	
	has_many	:award_assignments
	has_many	:assigned_users, :through => :award_assignments, :class_name => 'User', :source => :user

	
	has_attached	:avatar
	
	scope :amazon, where( 'asin is not null' )
	scope :coupon, where( 'asin is null' )
	
	
	def award_type
		return self.asin.present? ? 'product' : 'coupon'
	end
	
	def available_to?( user )
		self.assigned_users.include?( user )
	end
	
	def self.create_from_amazon( award )
		result = Amazon::Ecs.item_search( award[:asin], :response_group => 'Medium', :search_index => award[:search_index] ).items.first
		if result.nil?
			return "didn't find product for asin #{asin}"
		end
		
		award = Award.new( :name => result.get('title'), :description => result.get('editorialreview/content'), :asin =>award[:asin] )
		award.point_cost = result.get('formattedprice').gsub( /\D/, "" ).to_i.roundup
		if award.save
			avatar = Attachment.create_from_resource( result.get('mediumimage/url'), 'avatar', :owner => award, :remote => 'true' )
			return award
		else
			return "couldn't save award"
		end
	end
end
