# == Schema Information
# Schema version: 20101209043322
#
# Table name: unlockables
#
#  id           :integer(4)      not null, primary key
#  objective_id :integer(4)
#  name         :string(255)
#  description  :text
#  asin         :string(255)
#  points       :integer(4)
#  level        :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class Unlockable < ActiveRecord::Base
	has_many	:ownings
	has_many	:children, :through => :ownings
	
	has_attached	:avatar
	
	def self.create_from_amazon( asin, search_index )
		result = Amazon::Ecs.item_search( asin, :response_group => 'Medium', :search_index => search_index ).items.first
		if result.nil?
			return "didn't find product for asin #{asin}"
		end
		
		unlockable = Unlockable.new( :name => result.get('title'), :description => result.get('editorialreview/content') )
		
		if unlockable.save
			avatar = Attachment.create_from_resource( result.get('mediumimage/url'), 'avatar', :owner => unlockable, :remote => 'true' )
			return unlockable
		else
			return "couldn't save unlockable"
		end
	end
end
