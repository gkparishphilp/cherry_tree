class Approval < ActiveRecord::Base
	belongs_to :checkin
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
	
end