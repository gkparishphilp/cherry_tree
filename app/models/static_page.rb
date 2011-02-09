# == Schema Information
# Schema version: 20110207173417
#
# Table name: static_pages
#
#  id            :integer(4)      not null, primary key
#  site_id       :integer(4)
#  title         :string(255)
#  description   :string(255)
#  permalink     :string(255)
#  redirect_path :string(255)
#  content       :text
#  created_at    :datetime
#  updated_at    :datetime
#



class StaticPage < ActiveRecord::Base
	before_create 	:set_description
	before_save		:clean_permalink
    
	validate    	:valid_permalink?
	validates		:permalink, :uniqueness => true
	
	belongs_to :site


	def self.invalid_permalinks
		invalid_words = APP_ROUTE_PATHS.map { |route| route.path.to_s.match( /\w+\W/ ).to_s.chop }.uniq
	end
	
protected 
	def set_description
		self.description = self.content[0..200] if self.description.blank?
	end

	def clean_permalink
		self.permalink.gsub!(/\W/, "-")
	end
    
private
	def valid_permalink?
		if StaticPage.invalid_permalinks.include?( permalink )
			errors.add( :permalink, "Conflicts with existing routes." )
		end
	end
end
