# == Schema Information
# Schema version: 20110420185439
#
# Table name: journals
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  name       :string(255)
#  private    :boolean(1)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Journal < ActiveRecord::Base
	belongs_to	:user
	has_many	:journal_entries
end
