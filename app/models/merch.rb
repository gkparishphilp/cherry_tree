# == Schema Information
# Schema version: 20110207173417
#
# Table name: merches
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  price       :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Merch < ActiveRecord::Base
end
