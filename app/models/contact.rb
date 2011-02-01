class Contact < ActiveRecord::Base
	belongs_to :user
	attr_accessor :email
end
