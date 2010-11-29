puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

puts "Setup default Site"
site = Site.create :name => "Seedz", :domain => 'localhost'

puts "Create some prizes"

u = Unlockable.create :name => '1 Hour Free Time', :description => "TV, Videogames, Playtime, the choice is yours - You've earned it!", :points_req => 100
u.attachments.create :attachment_type => 'avatar', :name => 'clock', :format => 'png', 
	:path => '/images/unlockables/clock.png', :remote => true

u = Unlockable.create :name => 'Pet Snarp', :description => "This lovable pet will stick with you no matter what", :points_req => 25
u.attachments.create :attachment_type => 'avatar', :name => 'reddog', :format => 'gif', 
	:path => '/images/unlockables/reddog.gif', :remote => true

u = Unlockable.create :name => 'Pet Purp', :description => "Cute, but craves attention", :points_req => 25
u.attachments.create :attachment_type => 'avatar', :name => 'purpdog', :format => 'gif', 
	:path => '/images/unlockables/purpdog.gif', :remote => true

u = Unlockable.create :name => 'Pet Quib', :description => "Always willing to play", :points_req => 25
u.attachments.create :attachment_type => 'avatar', :name => 'doggy', :format => 'gif', 
	:path => '/images/unlockables/doggy.gif', :remote => true

u = Unlockable.create :name => 'Ms. Daisy', :description => "A beautiful flower for your garden", :points_req => 10
u.attachments.create :attachment_type => 'avatar', :name => 'daisy', :format => 'gif', 
	:path => '/images/unlockables/daisy.gif', :remote => true

u = Unlockable.create :name => 'Sunny', :description => "A beautiful flower for your garden", :points_req => 10
u.attachments.create :attachment_type => 'avatar', :name => 'sunflower', :format => 'gif', 
	:path => '/images/unlockables/sunflower.gif', :remote => true

u = Unlockable.create :name => 'Poof', :description => "A beutiful flower for your garden", :points_req => 10
u.attachments.create :attachment_type => 'avatar', :name => 'spiked', :format => 'gif', 
	:path => '/images/unlockables/spiked.gif', :remote => true