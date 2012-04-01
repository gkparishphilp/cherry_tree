class AddLessonCategories < ActiveRecord::Migration
  def change
	create_table :lesson_categories do |t|
		t.string		:name
	end
	
	add_column	:lessons, :lesson_category_id, :integer
	add_column	:users, :newsletter_opt_in, :boolean, :default => false
  end

end
