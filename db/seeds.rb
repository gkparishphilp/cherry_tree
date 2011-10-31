
s = Site.create :name => 'Cherry Tree'

oc1 = ObjectiveCategory.create :name => 'Academics'
oc2 = ObjectiveCategory.create :name => 'Behavior'
oc3 = ObjectiveCategory.create :name => 'Social'
oc4 = ObjectiveCategory.create :name => 'Health'

obj = Objective.create :objective_category => oc1, :name => 'Start your homework on time', :description => 'Start your homework on time', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Turn in your daily homework', :description => 'Turn in your daily homework', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Get a good grade on your school work', :description => 'Get a good grade on your school work', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Show up to class on time', :description => 'Show up to class on time', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Do math without a calculator or computer', :description => 'Do math without a calculator or computer', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Volunteer an answer in your class', :description => 'Volunteer an answer in your class', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Learn and use a new vocabulary word', :description => 'Learn a new vocabulary word and use it on your parents', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Practice spelling a new word', :description => 'Practice spelling a new word', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Read a new book', :description => 'Read a new book', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Recite a poem to mom or dad', :description => 'Recite a poem to mom or dad', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Solve a puzzle', :description => 'Solve a puzzle', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Learn a new word in another language', :description => 'Learn a new word in another language', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Write a short story', :description => 'Write a short story', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Write a poem', :description => 'Write a poem', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Complete a science project', :description => 'Complete a science project', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Practice your writing skills', :description => 'Practice your writing skills', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Tie your shoes', :description => 'Tie your shoes', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Button or zip your shirt, sweater, or pants', :description => 'Button or zip your shirt, sweater, or pants', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Practice your musical instrument', :description => 'Practice your musical instrument', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Learn to play a new song', :description => 'Learn to play a new song', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc1, :name => 'Perform in a recital', :description => 'Perform in a recital', :creator => s, :point_value => 5


obj = Objective.create :objective_category => oc2, :name => 'Clean your room', :description => 'Clean your room', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Make your bed', :description => 'Make your bed', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Put your dirty clothes away', :description => 'Put your dirty clothes away', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Put your toys and belongings away', :description => 'Put your toys and belongings away', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Set the table', :description => 'Set the table', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Turn off your phone during dinner', :description => 'Turn off your phone during dinner', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Have dinner with the family', :description => 'Have dinner with the family', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Help make dinner', :description => 'Help make dinner', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Remain seated at dinner until excused', :description => 'Remain seated at dinner until excused', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Help clean up after dinner', :description => 'Help clean up after dinner', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Make your lunch', :description => 'Make your lunch', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Finish your chores', :description => 'Finish your chores', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Calmly manage anger or frustration', :description => 'Calmly manage anger or frustration', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Politely ask for help', :description => 'Politely ask for help', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Take responsibility for your actions', :description => 'Take responsibility for your actions', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Raise your hand before speaking', :description => 'Raise your hand before speaking', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc2, :name => 'Show patience when asking for something', :description => 'Show patience when asking for something', :creator => s, :point_value => 5

obj = Objective.create :objective_category => oc3, :name => 'Share a toy with someone else', :description => 'Share a toy with someone else', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Obey your teacher', :description => 'Share a toy with someone else', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Say hello to people who greet you', :description => 'Say hello to people who greet you', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Wave at people who wave to you', :description => 'Wave at people who wave to you', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Say please and thank you', :description => 'Say please and thank you', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Respond timely when asked a question', :description => 'Respond timely when asked a question', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Make eye contact when speaking', :description => 'Make eye contact when speaking to others', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Speak respectfully to others', :description => 'Speak respectfully to others', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Listen to others without interrupting', :description => 'Listen to others without interrupting', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Send a thank you note', :description => 'Send a thank you note to someone who was kind to you', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Introduce yourself to someone new', :description => 'Introduce yourself to someone new', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Invite a person to play or join you', :description => 'Invite a person to play or join in your activity', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Perform an act of kindness', :description => 'Perform an act of kindness', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Congratulate someone for a positive act', :description => 'Congratulate someone for a positive act', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Give someone a compliment', :description => 'Give someone a compliment', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Keep your hands and feet to yourself', :description => 'Keep your hands and feet to yourself', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Ask for help when you are confused', :description => 'Ask for help when you are confused or frustrated', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Wait your turn patiently', :description => 'Wait your turn patiently', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc3, :name => 'Show good sportsmanship', :description => 'Show good sportsmanship', :creator => s, :point_value => 5

obj = Objective.create :objective_category => oc4, :name => 'Eat your vegetables', :description => 'Eat your vegetables', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Try a new vegetable', :description => "Try a new vegetable", :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Eat a healthy snack', :description => 'Eat a healthy snack', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Eat a healthy lunch', :description => 'Eat a healthy lunch', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Drink something other than soda', :description => 'Drink something other than soda ', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Take your vitamins', :description => "Take your vitamins", :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Drink at least 2 servings of milk', :description => 'Drink at least 2 servings of milk', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Eat 5 servings of fruits or vegetables', :description => 'Eat at least 5 servings of fruits or vegetables', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Do 10 or more push ups', :description => 'Do 10 or more push ups', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Do 10 or more sit-ups', :description => 'Do 10 or more sit-ups', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Ride you bike for at least 10 minutes', :description => 'Ride you bike for at least 10 minutes', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Exercise or play actively for 30 minutes', :description => 'Exercise or play actively for at least 30 minutes', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Go to sports practice', :description => 'Go to sports practice', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Brush your teeth twice daily', :description => 'Brush your teeth twice daily', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Take a bath or shower daily', :description => 'Take a bath or shower daily', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Wash your hands before eating', :description => 'Wash your hands before eating', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Use deodorant', :description => 'Use deodorant', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Get at least 8 hours of sleep', :description => 'Get at least 8 hours of sleep', :creator => s, :point_value => 5
obj = Objective.create :objective_category => oc4, :name => 'Apply sunscreen before going outside', :description => 'Apply sunscreen before going outside', :creator => s, :point_value => 5

ac1 = AwardCategory.create :name => 'Time'
ac1.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'jpg', :path => '/images/awards/time.jpg', :remote => true

ac2 = AwardCategory.create :name => 'Money'
ac2.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'jpg', :path => '/images/awards/money.jpg', :remote => true

ac3 = AwardCategory.create :name => 'Stuff'
ac3.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'jpg', :path => '/images/awards/stuff.jpg', :remote => true

ac4 = AwardCategory.create :name => 'Fun'
ac4.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true

aw = Award.create :award_category => ac1, :name => "One hour of Free Time", :description => "Use it wisely!", :point_cost => 500, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'jpg', :path => '/images/awards/time.jpg', :remote => true
aw = Award.create :award_category => ac1, :name => "One hour of Video Game Time", :description => "Have Fun!", :point_cost => 500, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'jpg', :path => '/images/awards/time.jpg', :remote => true
aw = Award.create :award_category => ac1, :name => "One hour of TV Time", :description => "Approved shows only", :point_cost => 500, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'jpg', :path => '/images/awards/time.jpg', :remote => true
aw = Award.create :award_category => ac1, :name => "One Extra Hour before Bed Time", :description => "Use only on Fridays and weekends", :point_cost => 500, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'jpg', :path => '/images/awards/time.jpg', :remote => true

aw = Award.create :award_category => ac2, :name => "One Dollar", :description => "More stuffing for your piggy bank", :point_cost => 100, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'jpg', :path => '/images/awards/money.jpg', :remote => true
aw = Award.create :award_category => ac2, :name => "Five Dollars", :description => "More stuffing for your piggy bank", :point_cost => 500, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'jpg', :path => '/images/awards/money.jpg', :remote => true
aw = Award.create :award_category => ac2, :name => "Ten Dollars", :description => "More stuffing for your piggy bank", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'jpg', :path => '/images/awards/money.jpg', :remote => true
aw = Award.create :award_category => ac2, :name => "Gift Card", :description => "For your favorite store", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'jpg', :path => '/images/awards/money.jpg', :remote => true


aw = Award.create :award_category => ac3, :name => "New Toy", :description => "Something that you've wanted", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'jpg', :path => '/images/awards/stuff.jpg', :remote => true
aw = Award.create :award_category => ac3, :name => "New Video Game", :description => "Something that you've wanted", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'jpg', :path => '/images/awards/stuff.jpg', :remote => true
aw = Award.create :award_category => ac3, :name => "New Clothes", :description => "Something that you've wanted", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'jpg', :path => '/images/awards/stuff.jpg', :remote => true
aw = Award.create :award_category => ac3, :name => "New Book", :description => "Something that you've wanted", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'jpg', :path => '/images/awards/stuff.jpg', :remote => true


aw = Award.create :award_category => ac4, :name => "Trip to Fun Place", :description => "The zoo, the beach, fishing, etc.", :point_cost => 2000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to Theme Park", :description => "Lots of fun!", :point_cost => 2000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to a Restaurant", :description => "Let's go out to your favorite restaurant.", :point_cost => 2000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to the Movies", :description => "Pick a good one!", :point_cost => 1000, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true
aw = Award.create :award_category => ac4, :name => "Movie Rental", :description => "Pick a good one!", :point_cost => 100, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to a Special Event", :description => "Concert, show, etc.", :point_cost => 2500, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'jpg', :path => '/images/awards/fun.jpg', :remote => true


l = Lesson.create :name => 'How to use Cherry Tree', :description => "How Cherry Tree works and how to get the most out of it."
s1 = l.screens.create :sequence => 1, :content => "To get the most out of Cherry Tree, try to log in every day."
s2 = l.screens.create :sequence => 2, :content => "Remember, honesty is the best policy.  If you did not accomplish your objectives, just say so, and work harder the next time."
s3 = l.screens.create :sequence => 3, :content => "You have supporters.  You can send them notes!"

q = l.quizzes.create :name => "A quiz for How to use Cherry Tree", :point_value => 100
quest = q.questions.create :content => "If you didn't acheive one of your objectives, what should you do?"
quest2 = q.questions.create :content => "How often should you log into Cherry Tree?"
quest2.answers.create :content => 'When You feel like it'
quest2.answers.create :content => 'Every Day', :correct => true
quest2.answers.create :content => 'Once a week'
quest3 = q.questions.create :content => 'What are your goals for the next month?'

l2 = Lesson.create :name => "You are who you hang out with", :description => "A lesson about friends and how they affect the way others see you"
l2.screens.create :sequence => 1, :content => "When you hang out by yourself, people focus on you.  People might concentrate on how you look, what you do, what you say, and what your personality is like."
l2.screens.create :sequence => 2, :content => "When you hang out with a group of kids, people focus on the group rather than on the specific people in it.  They consider how the group looks, what the people in the group do, and what they say.  Sometimes people behave differentyl in a group than they would by themselves."
q2 = l2.quizzes.create :name => "A quiz for 'You Are Who You Hang Out With'", :point_value => 50
quest1 = q2.questions.create :content => 'What type of impression do people get from the group that you hang out in?  Describe your group according to how it looks, what you do in the group, and what people in your group might talk about.'
quest2 = q2.questions.create :content => 'Impressions can be good, bad, or so-so.  How do impressions about your group rub off on you when you are not in the group?'
quest3 = q2.questions.create :content => 'If you want to make a better impression than your group made on someone specific, what are some things you can think about and do around that person?'

l3 = Lesson.create :name => 'Taking Time to Give Yourself a Compliment'
l3.screens.create :sequence => 1, :content => 'We all keep working on getting better at things.  This means we have to catch ourselves when we are not doing something well, tell ourselves to do better, and then work at rtying to improve it!'
l3.screens.create :sequence => 2, :content => 'As simple as this sounds, it takes a lot of work! It also makes us focus on what is already hard for us, which is usually not fun to do.'
l3.screens.create :sequence => 3, :content => 'So, we also need to remember that there is plenty that we already do well, and we have to tell ourselves that each and every day!'
l3.screens.create :sequence => 4, :content => "Each day, we should make a point to tell ourselves (quietly, in our head...so others don't think we're boasting) what it is we have done well for that day, hour or moment.  The compliments we tell ourselves should focus on small things we have paid attention to and tried to modify.  Do not wait until you have done one big thing well to give yourself a compliment.  You need to talk to yourself in your positive voice every day!"
l3.screens.create :sequence => 5, :content => 'When you become good at giving yourself small compliments each day, you are on your way to being your very own coach.  The more you coach yourself, the less you have people telling you what you should do!'
q3 = l3.quizzes.create :name => "A quiz for 'Taking Time to Give Yourself a Compliment'", :point_value => 50
quest1 = q3.questions.create :content => 'Go ahead and list 3 little things you have done well today:'


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

puts "Create admins"
u1.make_admin( s )
u2.make_admin( s )

puts "Create forums"
f = Forum.create :title => 'General', :description => 'Anything and Everything'
f = Forum.create :title  => 'Socialization', :description => 'Autism, Aspergers, Playing well with others'
f = Forum.create :title  => 'Attention', :description => 'ADD, Focus, Time Management'


# some unlockables

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
