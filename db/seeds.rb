puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

puts "Setup default Site"
site = Site.create :name => "Seedz", :domain => 'localhost'
