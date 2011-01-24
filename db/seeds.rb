puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

u1 = User.new :name => 'Gk'
u1.password = '1234'
u1.save( false )

c = u1.children.create :name => 'Avery', :birthday => '2002-3-12'
c.password = '1234'
c.save

c.relations.first.update_attributes :role => 'father'

puts "Setup default Site"
site = Site.create :name => "Cherry Tree", :domain => 'localhost'
# Todo - change to following for production:
# site = Site.create :name => "Cherry Tree", :domain => 'thecherrytree.com'

u1.make_admin site

puts "Create some forums"
f = Forum.create :title => "General", :description => 'Just a place to hang out and discuss anything and everything'
f = Forum.create :title => "Exercise", :description => 'Discuss excersize and activities'
f = Forum.create :title => "Nutrition", :description => 'Discuss nutrition'

puts "Create some prizes"

u = Unlockable.create :name => '1 Hour Free Time', :description => "TV, Videogames, Playtime, the choice is yours - You've earned it!", :points => 100
u.attachments.create :attachment_type => 'avatar', :name => 'clock', :format => 'png', 
	:path => '/images/unlockables/clock.png', :remote => true

u = Unlockable.create :name => 'Pet Snarp', :description => "This lovable pet will stick with you no matter what", :points => 25
u.attachments.create :attachment_type => 'avatar', :name => 'reddog', :format => 'gif', 
	:path => '/images/unlockables/reddog.gif', :remote => true

u = Unlockable.create :name => 'Pet Purp', :description => "Cute, but craves attention", :points => 25
u.attachments.create :attachment_type => 'avatar', :name => 'purpdog', :format => 'gif', 
	:path => '/images/unlockables/purpdog.gif', :remote => true

u = Unlockable.create :name => 'Pet Quib', :description => "Always willing to play", :points => 25
u.attachments.create :attachment_type => 'avatar', :name => 'doggy', :format => 'gif', 
	:path => '/images/unlockables/doggy.gif', :remote => true

u = Unlockable.create :name => 'Ms. Daisy', :description => "A beautiful flower for your garden", :points => 10
u.attachments.create :attachment_type => 'avatar', :name => 'daisy', :format => 'gif', 
	:path => '/images/unlockables/daisy.gif', :remote => true

u = Unlockable.create :name => 'Sunny', :description => "A beautiful flower for your garden", :points => 10
u.attachments.create :attachment_type => 'avatar', :name => 'sunflower', :format => 'gif', 
	:path => '/images/unlockables/sunflower.gif', :remote => true

u = Unlockable.create :name => 'Poof', :description => "A beutiful flower for your garden", :points => 10
u.attachments.create :attachment_type => 'avatar', :name => 'spiked', :format => 'gif', 
	:path => '/images/unlockables/spiked.gif', :remote => true
	
puts "Create a Game"
g = Game.create :name => "Breakout", :points => 20
g = Game.create :name => "Goog_Pac", :content => ".", :points => 20
puts "Create a Random Quiz"

q= Quiz.create :name => "A Random Quiz", :points => 100

qu = q.questions.create :content => "Why is the sky Blue?"
qu.answers.create :content => "It is?"
qu.answers.create :content => "Just Because"
qu.answers.create :content => "Because of the vibrations of tiny particles that filter and disperse light", :correct => true
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


puts "Create a Children's Nutrition Quiz"

q= Quiz.create :name => "A Children's Nutrition Quiz", :points => 150

qu = q.questions.create :content => "A cola drink is not a very good thing to drink before bedtime because of an ingredient called _____ that may keep you awake."
qu.answers.create :content => "Water"
qu.answers.create :content => "Caffeine", :correct => true
qu.answers.create :content => "Sodium"
qu.answers.create :content => "Potassium"

qu = q.questions.create :content => "Of the following snack items, which is the least healthy?"
qu.answers.create :content => "French fries", :correct => true
qu.answers.create :content => "Air-popped popcorn"
qu.answers.create :content => "An apple"
qu.answers.create :content => "Raisins"
qu.answers.create :content => "Peanut Butter"

qu = q.questions.create :content => "What does calcium do for the body?"
qu.answers.create :content => "Improves Eyesight"
qu.answers.create :content => "Builds strong bones", :correct => true
qu.answers.create :content => "Repairs muscle tissue"
qu.answers.create :content => "Aids flexibility"

qu = q.questions.create :content => "A completely vegetarian diet can be just as healthy as one that includes animal products."
qu.answers.create :content => "True", :correct => true
qu.answers.create :content => "False"

qu = q.questions.create :content => "Going by the food pyramid, from which food group should you get most of your food?"
qu.answers.create :content => "Fruits"
qu.answers.create :content => "Vegetables", :correct => true
qu.answers.create :content => "Milk"
qu.answers.create :content => "Grains"

qu = q.questions.create :content => "Again Going by the food pyramid, how many servings of vegetables should you get every day?"
qu.answers.create :content => "2"
qu.answers.create :content => "3"
qu.answers.create :content => "4"
qu.answers.create :content => "5", :correct => true

qu = q.questions.create :content => "Iron is important because:"
qu.answers.create :content => "It helps keep the kidneys functioning well"
qu.answers.create :content => "It helps balance blood sugar levels"
qu.answers.create :content => "It builds strong bones"
qu.answers.create :content => "Helps prevent infections and anemia that can make you feel tired", :correct => true

qu = q.questions.create :content => "Orange juice is good for you because it contains plenty of vitamin _____."
qu.answers.create :content => "A"
qu.answers.create :content => "B12"
qu.answers.create :content => "C", :correct => true
qu.answers.create :content => "D"

qu = q.questions.create :content => "A nutritionist studies:"
qu.answers.create :content => "How our bodies moves"
qu.answers.create :content => "The foods we eat", :correct => true
qu.answers.create :content => "How we learn"
qu.answers.create :content => "How much sleep we need"

qu = q.questions.create :content => "Which has more calories?"
qu.answers.create :content => "A pound of spinach"
qu.answers.create :content => "A gallon of water"
qu.answers.create :content => "A tablespoon of olive oil", :correct => true


qu = q.questions.create :content => "Foods such as tacos and pizza that are made up of items from different food groups are called _____ foods."
qu.answers.create :content => "Unhealthy"
qu.answers.create :content => "Omnidimensional"
qu.answers.create :content => "Messy"
qu.answers.create :content => "Combination", :correct => true

qu = q.questions.create :content => "Another term for Riboflavin is: "
qu.answers.create :content => "Vitamin C"
qu.answers.create :content => "Vitamin B12"
qu.answers.create :content => "Vitamin D"
qu.answers.create :content => "Vitamin B2", :correct => true
qu.answers.create :content => "None of the above"
qu.answers.create :content => "All of the above"






