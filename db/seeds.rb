
s = Site.create :name => 'Cherry Tree'

lc1 = LessonCategory.create :name => 'Academics & School Readiness'
lc2 = LessonCategory.create :name => 'Child Behavior & Independence Skills'
lc3 = LessonCategory.create :name => 'Social Skills & Emotional Well-Being'
lc4 = LessonCategory.create :name => 'Health & Fitness'

oc1 = ObjectiveCategory.create :name => 'Academics & School Readiness'
oc2 = ObjectiveCategory.create :name => 'Child Behavior & Independence Skills'
oc3 = ObjectiveCategory.create :name => 'Social Skills & Emotional Well-Being'
oc4 = ObjectiveCategory.create :name => 'Health & Fitness'

osc1 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Listening'
osc2 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Obeying'
osc3 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Patience'
osc4 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Self-Advocating'
osc5 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Flexibility'
osc6 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Independence'
osc7 = ObjectiveSubcategory.create :objective_category => oc2, :name => 'Home/Chores'

osc8  = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Friendship'
osc9  = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Playtime'
osc10 = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Bullying'
osc11 = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Communication'
osc12 = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Being Kind'
osc13 = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Body Awareness'
osc14 = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Cope with Feelings'
osc15 = ObjectiveSubcategory.create :objective_category => oc3, :name => 'Self-Esteem/Self-Confidence'

osc16 = ObjectiveSubcategory.create :objective_category => oc4, :name => 'Motor Development'
osc17 = ObjectiveSubcategory.create :objective_category => oc4, :name => 'Nutrition/Diet'
osc18 = ObjectiveSubcategory.create :objective_category => oc4, :name => 'Mental'
osc19 = ObjectiveSubcategory.create :objective_category => oc4, :name => 'Physical/Exercise'
osc20 = ObjectiveSubcategory.create :objective_category => oc4, :name => 'Hygiene'
osc21 = ObjectiveSubcategory.create :objective_category => oc4, :name => 'Safety'

osc22 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Reading/Language Arts'
osc23 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Writing'
osc24 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Math'
osc25 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Art/Music'
osc26 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Schoolword'
osc27 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Learn New Skill'

obj = Objective.create :objective_category => oc2, :objective_subcategory => osc1, :name => 'Show good listening skills by making good eye contact and do not interrupt', :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc1, :name => 'Repeat back the instructions given to you', :creator => s, :point_value => 1


puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( :validate => false )

puts "Create GK's test data"
u1 = User.new :name => 'Gk', :email => 'gk@thecherrytree.com', :display_name => 'Gk'
u1.password = '1234'
u1.save( :validate => false )

puts "Create Tay's test data"

u2 = User.new :name => 'Tay', :email => 'tay@thecherrytree.com', :display_name => 'Tay'
u2.password = '1234'
u2.save( :validate => false )

puts "Create Anthony's test data"

u3 = User.new :name => 'Anthony', :email => 'anthonysessa@gmail.com', :display_name => 'Anthony'
u3.password = '123123'
u3.save( :validate => false )

puts "Create admins"
u1.make_admin( s )
u2.make_admin( s )
u3.make_admin( s )

puts "Create forums"
f = Forum.create :title => 'General', :description => 'Anything and Everything'
f = Forum.create :title  => 'Socialization', :description => 'Autism, Aspergers, Playing well with others'
f = Forum.create :title  => 'Attention', :description => 'ADD, Focus, Time Management'


puts "Create static pages"

# Static Pages
about = ""
File.open("#{Rails.root}/copy/about.txt") {|f| about = f.read}	
sp = StaticPage.create :title => 'About Us', :permalink => 'about', 
					:description => 'About Us', :content => about

terms = ""
File.open("#{Rails.root}/copy/terms.txt") {|f| terms = f.read}	
sp = StaticPage.create :title => 'Terms of Use', :permalink => 'terms', 
					:description => 'Terms of Use', :content => terms

privacy = ""
File.open("#{Rails.root}/copy/privacy.txt") {|f| privacy = f.read}	
sp = StaticPage.create :title => 'Privacy Policy', :permalink => 'privacy', 
					:description => 'Privacy', :content => privacy
					
help = ""
File.open("#{Rails.root}/copy/help.txt") {|f| help = f.read}	
sp = StaticPage.create :title => 'Help', :permalink => 'help', 
					:description => 'Help', :content => help

blog1 = ""
File.open("#{Rails.root}/copy/welcome_blog.txt") {|f| blog1 = f.read} 
article = Article.create :owner_id => u2.id, :owner_type => 'User', :title => 'Welcome!', 
						:comments_allowed => true, :status => 'publish', :publish_at => '2011-10-21 19:00:00', :content => blog1

=begin

#ul = Unlockable.create :name => 'Pet Snarp', :description => "This lovable pet will stick with you no matter what", :point_cost => 25
#ul.attachments.create :attachment_type => 'avatar', :name => 'reddog', :format => 'gif', :path => '/images/unlockables/reddog.gif', :remote => true

#ul = Unlockable.create :name => 'Poof', :description => "A beutiful flower for your TreeHouse", :point_cost => 10
#ul.attachments.create :attachment_type => 'avatar', :name => 'spiked', :format => 'gif', :path => '/images/unlockables/spiked.gif', :remote => true

puts "Create stickers"
s = Sticker.create :name => 'Beaver', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'beaver', :format => 'png', :path => '/images/stickers/beaver.png', :remote => true

s = Sticker.create :name => 'Blue Bird', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'blue_bird', :format => 'png', :path => '/images/stickers/blue_bird.png', :remote => true

s = Sticker.create :name => 'butterfly1', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'butterfly1', :format => 'png', :path => '/images/stickers/butterfly1.png', :remote => true

s = Sticker.create :name => 'butterfly2', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'butterfly2', :format => 'png', :path => '/images/stickers/butterfly2.png', :remote => true

s = Sticker.create :name => 'Cat', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'cat', :format => 'png', :path => '/images/stickers/cat.png', :remote => true

s = Sticker.create :name => 'Flower', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'flower', :format => 'png', :path => '/images/stickers/flower.png', :remote => true

s = Sticker.create :name => 'Frog', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'frog', :format => 'png', :path => '/images/stickers/frog.png', :remote => true

s = Sticker.create :name => 'Heart', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'heart', :format => 'png', :path => '/images/stickers/heart.png', :remote => true

s = Sticker.create :name => 'Lady Bug', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'ladybug', :format => 'png', :path => '/images/stickers/ladybug.png', :remote => true

s = Sticker.create :name => 'Sham Rock', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'shamrock', :format => 'png', :path => '/images/stickers/shamrock.png', :remote => true

s = Sticker.create :name => 'Squirrel', :point_cost => 10
s.attachments.create :attachment_type => 'avatar', :name => 'squirrel', :format => 'png', :path => '/images/stickers/squirrel.png', :remote => true

puts "Create some fonts"
f = Font.create :name => 'vt323', :resource_path => 'http://fonts.googleapis.com/css?family=VT323', :point_cost => 10, :description => 'Computery'
f = Font.create :name => 'expletus', :resource_path => 'http://fonts.googleapis.com/css?family=Expletus+Sans', :point_cost => 10
f = Font.create :name => 'slackey', :resource_path => 'http://fonts.googleapis.com/css?family=Slackey', :point_cost => 10
f = Font.create :name => 'sunshiney', :resource_path => 'http://fonts.googleapis.com/css?family=Sunshiney', :point_cost => 10
f = Font.create :name => 'schoolbell', :resource_path => 'http://fonts.googleapis.com/css?family=Schoolbell', :point_cost => 10
f = Font.create :name => 'homemade_apple', :resource_path => 'http://fonts.googleapis.com/css?family=Homemade+Apple', :point_cost => 10
f = Font.create :name => 'cranky', :resource_path => 'http://fonts.googleapis.com/css?family=Kranky', :point_cost => 10, :description => 'A cranky font for a cranky day'
f = Font.create :name => 'growler', :resource_path => 'http://fonts.googleapis.com/css?family=Irish+Growler', :point_cost => 10
f = Font.create :name => 'stencil', :resource_path => 'http://fonts.googleapis.com/css?family=Allerta+Stencil', :point_cost => 10
f = Font.create :name => 'coming_soon', :resource_path => 'http://fonts.googleapis.com/css?family=Coming+Soon', :point_cost => 10

puts "Create backgrounds"

b1 = Background.create :name => 'blue_paisley', :repeat => 'none', :point_cost => 40
b1.attachments.create :attachment_type => 'image', :name => 'blue_paisley', :format => 'jpg', :path => '/images/backgrounds/blue_paisley.jpg', :remote => true
b2 = Background.create :name => 'parchment', :repeat => 'none', :point_cost => 40
b2.attachments.create :attachment_type => 'image', :name => 'parchment', :format => 'jpg', :path => '/images/backgrounds/parchment.jpg', :remote => true
b3 = Background.create :name => 'notebook', :repeat => 'none', :point_cost => 20
b3.attachments.create :attachment_type => 'image', :name => 'notebook', :format => 'png', :path => '/images/backgrounds/notebook_paper.png', :remote => true


#a = Achievement.create :name => 'Journalist', :requirements => "journal_entries.count > 0"
#a = Achievement.create :name => 'Wish Master', :requirements => "wishlist_items.count > 0"
#a = Achievement.create :name => 'Biographer', :requirements => "bio.present?"
#a = Achievement.create :name => 'First Checkin!', :requirements => "checkins.count > 0"

=end 
