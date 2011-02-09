# == Schema Information
# Schema version: 20110207173417
#
# Table name: awards
#
#  id           :integer(4)      not null, primary key
#  objective_id :integer(4)
#  merch_id     :integer(4)
#  creator_id   :integer(4)
#  creator_type :string(255)
#  name         :string(255)
#  description  :text
#  asin         :string(255)
#  points       :integer(4)
#  level        :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class Award < ActiveRecord::Base
	belongs_to	:creator, :polymorphic => true
	has_many	:ownings
	has_many	:children, :through => :ownings
	
	has_attached	:avatar
	
	scope :available, lambda {|*args| 
			where('(child_id = ? or child_id is NULL) and points is NOT NULL', args.first)
	}
	
	def self.create_from_amazon( award )
		result = Amazon::Ecs.item_search( award[:asin], :response_group => 'Medium', :search_index => award[:search_index] ).items.first
		if result.nil?
			return "didn't find product for asin #{asin}"
		end
		
		award = Award.new( :name => result.get('title'), :description => result.get('editorialreview/content'), :child_id => award[:child_id], :points => award[:points], :level => award[:level], :asin =>award[:asin] )
		
		if award.save
			avatar = Attachment.create_from_resource( result.get('mediumimage/url'), 'avatar', :owner => award, :remote => 'true' )
			return award
		else
			return "couldn't save award"
		end
	end
end
