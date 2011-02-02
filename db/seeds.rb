puts "Setup Default Anonymous User"

anon = User.new :name => 'Anonymous'
anon.save( false )

u1 = User.new :name => 'Gk'
u1.password = '1234'
u1.save( false )

s = Site.create :name => 'Cherry Tree'

u1.make_admin( s )
