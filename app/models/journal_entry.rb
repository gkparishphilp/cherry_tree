# == Schema Information
# Schema version: 20110210211558
#
# Table name: journal_entries
#
#  id         :integer(4)      not null, primary key
#  journal_id :integer(4)
#  title      :string(255)
#  content    :text
#  private    :boolean(1)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class JournalEntry < ActiveRecord::Base
	belongs_to	:journal
	
	has_many	:comments, :as => :commentable
	
	
	
end
