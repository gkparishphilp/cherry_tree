# == Schema Information
# Schema version: 20110228224652
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
	
	has_many	:stickings, :as => :stickable
	has_many	:photo_attachments, :as => :attachable
	
end
