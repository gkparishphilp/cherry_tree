# == Schema Information
# Schema version: 20110420185439
#
# Table name: award_assignments
#
#  id          :integer(4)      not null, primary key
#  award_id    :integer(4)
#  user_id     :integer(4)
#  creator_id  :integer(4)
#  description :text
#  point_cost  :integer(4)
#  recurring   :boolean(1)      default(TRUE)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class AwardAssignment < ActiveRecord::Base
	
	validates	:point_cost, :numericality => { :greater_than => 0 }
	
	belongs_to	:award
	belongs_to	:user
	belongs_to	:creator, :foreign_key => 'creator_id', :class_name => 'User'
	
	attr_accessor	:award_name, :award_description, :asin, :index, :term
	
	
	scope :active, where( "status = 'active'" )
	
	def active?
		self.status == 'active' ? (return true) : (return false)
	end
end
