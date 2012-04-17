# == Schema Information
# Schema version: 20110420185439
#
# Table name: objective_categories
#
#  id   :integer(4)      not null, primary key
#  name :string(255)
#

class ObjectiveCategory < ActiveRecord::Base

	has_many	:objectives
	has_many	:objective_subcategories
	has_attached	:avatar

end
