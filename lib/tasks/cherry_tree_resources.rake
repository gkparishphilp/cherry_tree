task :cherry_tree_resources => :environment do

	c1 = ObjectiveCategory.find_by_name 'Academics & School Readiness'
	c2 = ObjectiveCategory.find_by_name 'Child Behavior & Independence Skills'
	c3 = ObjectiveCategory.find_by_name 'Social Skills & Emotional Well-Being'
	c4 = ObjectiveCategory.find_by_name 'Health & Fitness'

	r1 = ""
	File.open("#{Rails.root}/copy/resources/academic_motivation.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c1.id, :title => 'Motivation', :content => r1

	File.open("#{Rails.root}/copy/resources/academic_reading.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c1.id, :title => 'Reading', :content => r1
	
	File.open("#{Rails.root}/copy/resources/behavior_attention_problems.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c2.id, :title => 'Attention Problems', :content => r1
	
	File.open("#{Rails.root}/copy/resources/behavior_cohesive_discipline.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c2.id, :title => 'Cohesive Discipline', :content => r1
	
	File.open("#{Rails.root}/copy/resources/behavior_household_chores.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c1.id, :title => 'Household Chores', :content => r1
	
	File.open("#{Rails.root}/copy/resources/behavior_self_control.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c2.id, :title => 'Self Control', :content => r1

	File.open("#{Rails.root}/copy/resources/behavior_table_manners.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c2.id, :title => 'Table Manners', :content => r1

	File.open("#{Rails.root}/copy/resources/health_obesity.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c4.id, :title => 'Obesity', :content => r1

	File.open("#{Rails.root}/copy/resources/health_sports.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c4.id, :title => 'Sports', :content => r1

	File.open("#{Rails.root}/copy/resources/independence_confident_daughter.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c2.id, :title => 'Confident Daughter', :content => r1

	File.open("#{Rails.root}/copy/resources/social_anger_management.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Anger Management', :content => r1

	File.open("#{Rails.root}/copy/resources/social_child_dependency.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Child Dependency', :content => r1

	File.open("#{Rails.root}/copy/resources/social_stress_in_children.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Stress in Children', :content => r1

	File.open("#{Rails.root}/copy/resources/social_tantrums.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Tantrums', :content => r1

	File.open("#{Rails.root}/copy/resources/social-peer-relationships.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Peer Relationships', :content => r1

	File.open("#{Rails.root}/copy/resources/social-self-esteem.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Self Esteem', :content => r1

	File.open("#{Rails.root}/copy/resources/social-sharing.html") {|f| r1 = f.read}	
	r = Resource.create :objective_category_id => c3.id, :title => 'Sharing', :content => r1


end
