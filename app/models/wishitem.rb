class Wishitem < ActiveRecord::Base
	belongs_to	:child
	attr_accessor :name, :description
end
