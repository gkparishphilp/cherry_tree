
s = Site.create :name => 'Cherry Tree'

o = Objective.create :name => 'Be Good'

puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

u1 = User.new :name => 'Gk', :email => 'gk.parishphilp@gmail.com'
u1.password = '1234'
u1.save( false )

c1 = u1.children.create :name => 'Avery', :gender => 'female', :birthday => 6.years.ago, :password => '1234'
u1.relate_to c1, :as => 'father', :nickname => 'Daddy'

n1 = u1.write_note :to => c1, :subject => 'Hi, Welcome to the Site', :content => "I can't wait to play this with you. I know you are going to do great! Love You!!!"

c2 = u1.children.create :name => 'Karl', :gender => 'female', :birthday => 3.years.ago, :password => '1234'
c2.password = '1234'
u1.relate_to c2, :as => 'father', :nickname => 'Pops'

n2 = u1.write_note :to => c2, :subject => 'You da Man!', :content => "Hey, great Job!"


u2 = User.new :name => 'Tay', :email => 'tay.x.nguyen@gmail.com'
u2.password = '1234'
u2.save( false )

c3 = u2.children.create :name => 'Ethan', :gender => 'male', :birthday => 7.years.ago, :password => '1234'
c3.password = '1234'
u2.relate_to c3, :as => 'father', :nickname => 'Dad'

c4 = u2.children.create :name => 'Grace', :gender => 'female', :birthday => 5.years.ago, :password => '1234'
c4.password = '1234'
u2.relate_to c4, :as => 'father', :nickname => 'Dad'

u1.make_admin( s )
u2.make_admin( s )

#some objectives
o1 = Objective.create :name => 'Clean room', :objective_type => 'Chores', :creator_type =>'User', :creator_id => 2, :description => 'Pick up your toys'
o2 = Objective.create :name => 'Practice Guitar', :objective_type => 'Misc', :creator_type =>'User', :creator_id => 2, :description => 'Appregiate and Scalify'
o3 = Objective.create :name => 'Mow Lawn',  :objective_type => 'Chores', :creator_type =>'User', :creator_id => 2, :description => "Don't forget to sweep up"
o4 = Objective.create :name => 'Take out Trash',  :objective_type => 'Chores', :creator_type =>'User', :creator_id => 2, :description => "Take it out before it overflows"


a1 = ObjectiveAssignment.create :user_id => 6, :objective => o1, :creator_id => 5, :times => 3, :period => 'week', :req_checkin => 1, :req_confirm => 1, :point_value => 5
a2 = ObjectiveAssignment.create :user_id => 6, :objective => o2, :creator_id => 5, :times => 5, :period => 'week', :req_checkin => 1, :req_confirm => 1, :point_value => 10
a3 = ObjectiveAssignment.create :user_id => 6, :objective => o3, :creator_id => 5, :times => 1, :period => 'week', :req_checkin => 1, :req_confirm => 1, :point_value => 20
a4 = ObjectiveAssignment.create :user_id => 6, :objective => o4, :creator_id => 5, :times => 7, :period => 'week', :req_checkin => 1, :req_confirm => 0, :point_value => 100
 
# some unlockables

#ul = Unlockable.create :name => 'Pet Snarp', :description => "This lovable pet will stick with you no matter what", :point_cost => 25
#ul.attachments.create :attachment_type => 'avatar', :name => 'reddog', :format => 'gif', :path => '/images/unlockables/reddog.gif', :remote => true

#ul = Unlockable.create :name => 'Poof', :description => "A beutiful flower for your TreeHouse", :point_cost => 10
#ul.attachments.create :attachment_type => 'avatar', :name => 'spiked', :format => 'gif', :path => '/images/unlockables/spiked.gif', :remote => true

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

blog1 = ""
File.open("#{Rails.root}/copy/welcome_blog.txt") {|f| blog1 = f.read} 
article = Article.create :owner_id => u2.id, :owner_type => 'User', :title => 'Welcome!', :topic_list => 'Welcome', 
						:comments_allowed => true, :status => 'publish', :publish_at => '2011-02-01 19:00:00', :content => blog1
