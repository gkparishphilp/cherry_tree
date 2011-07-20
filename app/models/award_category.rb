# == Schema Information
# Schema version: 20110420185439
#
# Table name: award_categories
#
#  id   :integer(4)      not null, primary key
#  name :string(255)
#

class AwardCategory < ActiveRecord::Base

	has_many	:awards
	has_attached	:avatar
	
end
