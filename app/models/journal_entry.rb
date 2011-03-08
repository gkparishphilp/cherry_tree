# == Schema Information
# Schema version: 20110228224652
#
# Table name: journal_entries
#
#  id            :integer(4)      not null, primary key
#  journal_id    :integer(4)
#  title         :string(255)
#  content       :text
#  font_id       :integer(4)
#  background_id :integer(4)
#  border_id     :integer(4)
#  private       :boolean(1)
#  status        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class JournalEntry < ActiveRecord::Base
	belongs_to	:journal
	
	has_many	:comments, :as => :commentable
	
	belongs_to	:font
	belongs_to	:background
	belongs_to	:border
	
	has_many	:page_elements, :as => :page
	
end
