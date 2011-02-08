puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

u1 = User.new :name => 'Gk', :email => 'gk.parishphilp@gmail.com'
u1.password = '1234'
u1.save( false )

#c1 = u1.children.create :name => 'avery', :password => '1234', :display_name => 'Avery'
#u1.relations.new :role => 'father', :child_id => c1.id

#n1 = u1.sent_notes.create :subject => 'Hi, Welcome to the Site', :content => "I can't wait to play this with you. I know you are going to do great! Love, Dad"
#n1.deliver_to( c1 )

u2 = User.new :name => 'Tay', :email => 'tay.x.nguyen@gmail.com'
u2.password = '1234'
u2.save( false )

s = Site.create :name => 'Cherry Tree'

u1.make_admin( s )
u2.make_admin( s )

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
