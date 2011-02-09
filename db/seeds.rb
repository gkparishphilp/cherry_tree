
s = Site.create :name => 'Cherry Tree'

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

# some awards

a = s.managed_awards.create :name => '1 Hour Free Time', :description => "TV, Videogames, Playtime, the choice is yours - You've earned it!", :points => 100
a.attachments.create :attachment_type => 'avatar', :name => 'clock', :format => 'png', :path => '/images/unlockables/clock.png', :remote => true

a = s.managed_awards.create :name => 'Pet Snarp', :description => "This lovable pet will stick with you no matter what", :points => 25
a.attachments.create :attachment_type => 'avatar', :name => 'reddog', :format => 'gif', :path => '/images/unlockables/reddog.gif', :remote => true

a = s.managed_awards.create :name => 'Poof', :description => "A beutiful flower for your TreeHouse", :points => 10
a.attachments.create :attachment_type => 'avatar', :name => 'spiked', :format => 'gif', :path => '/images/unlockables/spiked.gif', :remote => true

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
