class AddWeeklyApprovals < ActiveRecord::Migration
  def self.up
	create_table :weekly_approvals, :force => true do |t|
		t.references :objective_assignment
		t.references :creator 
		t.date	:week_ending
		t.string	:status
		t.timestamps
	end
  end

  def self.down
  end
end
