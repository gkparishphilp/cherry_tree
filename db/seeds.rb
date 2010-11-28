puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

puts "Setup default Site"
site = Site.create :name => "Seedz", :domain => 'localhost'

puts "Create some prizes"
u = Unlockable.create :name => 'Pet Snarp', :description => "This lovable pet will stick with you no matter what", :points_req => 25
u = Unlockable.create :name => 'Pet Purp', :description => "Cute, but craves attention", :points_req => 25
u = Unlockable.create :name => 'Pet Quib', :description => "Always willing to play", :points_req => 25
u = Unlockable.create :name => 'Daise', :description => "A beautiful flower for your garden", :points_req => 10
u = Unlockable.create :name => 'Sunny', :description => "A beautiful flower for your garden", :points_req => 10
u = Unlockable.create :name => 'Poof', :description => "A beutiful flower for your garden", :points_req => 10
