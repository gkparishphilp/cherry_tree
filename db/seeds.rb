puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

u1 = User.new :name => 'Gk'
u1.password = '1234'
u1.save( false )

c = u1.children.create :name => 'Avery'
c.password = '1234'
c.save

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
	
puts "Create a Quiz"

q= Quiz.create :name => "A quick Quiz"

qu = q.questions.create :content => "Why is the sky Blue?"
qu.answers.create :content => "It is?"
qu.answers.create :content => "Just Because"
qu.answers.create :content => "Because of the vibrations of tint particles that filter and disperse light", :correct => true
qu.answers.create :content => "Because it was painted that way"

qu = q.questions.create :content => "Who Invented Gravity?"
qu.answers.create :content => "God", :correct => true
qu.answers.create :content => "Newton"
qu.answers.create :content => "Franklin"
qu.answers.create :content => "Einstein"

qu = q.questions.create :content => "What is the best color?"
qu.answers.create :content => "Blue"
qu.answers.create :content => "Green", :correct => true
qu.answers.create :content => "Red"
qu.answers.create :content => "Pink"
qu.answers.create :content => "Orange"
qu.answers.create :content => "Purple"
qu.answers.create :content => "Yellow"

qu = q.questions.create :content => "What is your favorite flavor Ice Cream?"
qu.answers.create :content => "Vanilla"
qu.answers.create :content => "Chocolate"
qu.answers.create :content => "Strawberry"
qu.answers.create :content => "None - Ice Cream is bad for you", :correct => true

