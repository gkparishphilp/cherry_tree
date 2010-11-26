puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )
