puts 'creating anon user'
anon = User.new :name => 'Anonymous'
anon.save( :validate => false )

puts 'creating site'
ct = Site.create( :name => 'cherrytree', :domain => 'localhost', :app_host => true )

puts 'creating template'
template = Template.create :name => 'CherryTree', :layout => 'application'
ct.apply_template template

puts 'creating test accts'
puts "Create GK's test acct"
gk = User.new( :email => 'gk@thecherrytree.com' )
gk.save( :validate => false )
gk.join_site( ct, :as => 'admin', :name => 'Gk', :password => '1234', :password_confirmation => '1234' )
