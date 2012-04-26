# == Schema Information
# Schema version: 20110420185439
#
# Table name: awards
#
#  id                :integer(4)      not null, primary key
#  creator_id        :integer(4)
#  creator_type      :string(255)
#  award_category_id :integer(4)
#  name              :string(255)
#  description       :text
#  asin              :string(255)
#  point_cost        :integer(4)
#  status            :string(255)     default("active")
#  created_at        :datetime
#  updated_at        :datetime
#

class Award < ActiveRecord::Base
	
	# after_create :set_avatar
	belongs_to	:award_category
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
	
	def assignment_for( user )
		return self.award_assignments.where( :user_id => user.id ).first
	end
	
	def self.create_from_amazon( award )
		result = Amazon::Ecs.item_search( award[:asin], :response_group => 'Medium', :search_index => award[:index] ).items.first
		if result.nil?
			return "didn't find product for asin #{asin}"
		end
		
		award = Award.new( :name => result.get('ItemAttributes/Title'), :description => result.get('EditorialReviews/EditorialReview/Content'), :asin =>award[:asin] )
		#award.point_cost = result.get('OfferSummary/LowestNewPrice/FormattedPrice').gsub( /\D/, "" ).to_i.roundup
		award.point_cost = 50
		if award.save
			avatar = Attachment.create_from_resource( result.get_hash( 'MediumImage' )['URL'], 'avatar', :owner => award, :remote => 'true' )
			return award
		else
			return "couldn't save reward"
		end
	end
	
	private
	
	def set_avatar
		if self.avatar.nil?
			pic = Attachment.create( :path => '/images/trophy.png', :name => 'trophy', :attachment_type => 'avatar', :owner => self, :format => 'png', :remote => true )
		end
	end
end
