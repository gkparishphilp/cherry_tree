
s = Site.create :name => 'Cherry Tree'

lc1 = LessonCategory.create :name => 'Academics & School Readiness', :short_name => 'academics', :sequence => 3
lc2 = LessonCategory.create :name => 'Child Behavior & Independence Skills', :short_name => 'behavior', :sequence => 1
lc3 = LessonCategory.create :name => 'Social Skills & Emotional Well-Being', :short_name => 'social', :sequence => 2
lc4 = LessonCategory.create :name => 'Health & Fitness', :short_name => 'health', :sequence => 4

oc1 = ObjectiveCategory.create :name => 'Academics & School Readiness', :short_name => 'academics', :sequence => 3
oc2 = ObjectiveCategory.create :name => 'Child Behavior & Independence Skills', :short_name => 'behavior', :sequence => 1
oc3 = ObjectiveCategory.create :name => 'Social Skills & Emotional Well-Being', :short_name => 'social', :sequence => 2
oc4 = ObjectiveCategory.create :name => 'Health & Fitness', :short_name => 'health', :sequence => 4

sc1 = StoreCategory.create :name => 'Academics & School Readiness', :short_name => 'academics', :sequence => 3
sc2 = StoreCategory.create :name => 'Child Behavior & Independence Skills', :short_name => 'behavior', :sequence => 1
sc3 = StoreCategory.create :name => 'Social Skills & Emotional Well-Being', :short_name => 'social', :sequence => 2
sc4 = StoreCategory.create :name => 'Health & Fitness', :short_name => 'health', :sequence => 4
sc5 = StoreCategory.create :name => 'Fun', :short_name => 'fun'

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
osc26 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Schoolwork'
osc27 = ObjectiveSubcategory.create :objective_category => oc1, :name => 'Learn New Skill'

# Good deed objective used for granting random points by parent
obj = Objective.create :name => "Good Deed", :creator => s

#Child Behavior & Independence Skills
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc1, :name => 'Show good listening skills by making good eye contact and do not interrupt', :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc1, :name => 'Repeat back the instructions given to you', :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc2, :name => 'Do what mom or dad tells you, the first time they tell you', :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc2, :name => 'Do what mom or dad tells you without arguing or complaining', :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc3, :name => "Wait your turn (don't cut in line or take someone else's turn)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc3, :name => "Remain seated at dinner until excused", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc3, :name => "When someone is speaking to you, wait until they are finished before you speak", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc4, :name => "Ask for help when you need it", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc4, :name => "Ask to use the bathroom", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc4, :name => "Ask to have something that you want", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc4, :name => "Speak up when you don't agree with something", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc5, :name => "Go through the day without throwing  a fit", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc5, :name => "Accept the choices given to you by your parent/teacher the first time", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc5, :name => "When plans change, accept the new plans without getting upset", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Dress yourself without help", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Brush your own teeth", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Brush your own hair", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Tie your shoes", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Go through the day without biting your nails", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Pay for something at a store", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Watch no more than 30 minutes of TV a day", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Solve a problem all by yourself", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Be on time to class or practice", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc6, :name => "Volunteer to answer or demonstrate in class or sports", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Put your toys and belongings away", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Clean your room", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Set the table", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Help make dinner", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Help clean up after dinner", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Make your lunch", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Rake the leaves", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc2, :objective_subcategory => osc7, :name => "Take out the garbage", :creator => s, :point_value => 1

#Social Skills & Emotional Well-Being
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc8, :name => "Wave at or greet someone that waves or greets you", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc8, :name => "Give a friend a compliment (eg, 'I like your outfit', or 'you look nice')", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc8, :name => "Say hello to a new person", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc9, :name => "Share your toys or belongings", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc9, :name => "Take turns with toys or when playing a game", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc9, :name => "Play with someone new", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc10, :name => "Stand up for someone who is being bullied, don't join in", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc10, :name => "Tell someone that is bullying you that you don't like it and they need to stop", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc10, :name => "Talk to a teacher or parent about someone that is being a bully", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc11, :name => "Ask a question when you didn't hear or understand something", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc11, :name => "Go through the day using a good voice volume when speaking to others (no yelling)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc11, :name => "Use good listening skills (show good eye contact and don't interrupt when speaking with others)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc12, :name => "Use nice words ('please', 'thank you', 'you're welcome')", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc12, :name => "Volunteer to help someone in need", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc12, :name => "Help someone when asked", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc12, :name => "Say sorry when you hurt someone with your words or actions", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc12, :name => "Encourage others", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc12, :name => "Congratulate others when they do a good job", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc13, :name => "Keep hands and feet to yourself (do not touch/push others in school or home)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc13, :name => "Respect people's personal space (stand a good distance from others when speaking)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc14, :name => "When you are upset or frustrated, count to ten or take deep breaths before reacting ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc14, :name => "When you are upset or frustrated, use your words to describe how you are feeling", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc14, :name => "When you are upset or frustrated, ask for help (no yelling or giving up)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc14, :name => "When you are upset or frustrated, keep angry words and hands to yourself ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc15, :name => "Write down three things that you did well today", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc15, :name => "Tell your mom and dad the good things you did today", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc3, :objective_subcategory => osc15, :name => "Volunteer to answer or demonstrate in class or sports", :creator => s, :point_value => 1

#Health & Fitness
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc16, :name => "Practice buttoning or zippering your shirt, sweater, or pants", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc16, :name => "Practice tying shoes", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc16, :name => "Hop on one foot for at least 30 seconds without falling", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc16, :name => "Skip for at least 1 minute", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc16, :name => "Practice jumping rope", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc16, :name => "Practice riding a bike or tricycle", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Eat no more than one small sweet a day", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Eat 3 servings of fruit and veggies a day", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Drink 3 tall glasses of water a day", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Drink 2 glasses of milk a day", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Try a new vegetable", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Go through the day without  drinking soda ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Eat breakfast", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc17, :name => "Take your vitamins", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc18, :name => "Meditate for 1 minute", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Do 15 minutes of exercise ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Do 10 pushups", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Do 10 sit ups", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Ride your bike for at least 10 minutes", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Exercise or play actively for 30 minutes", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Walk the dog", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc19, :name => "Practice a sport for 15-20 minutes", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc20, :name => "Go a full day without a toileting accident ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc20, :name => "Practice wiping yourself clean when going to the bathroom", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc20, :name => "Take a shower/bath (adult may assist)", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc20, :name => "Brush your teeth twice a day ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc21, :name => "Wear safety helmet and pads", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc21, :name => "Look both ways before crossing the street", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc21, :name => "Lock all safety gates in the home for younger siblings", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc4, :objective_subcategory => osc21, :name => "Tell a parent before you go out to play", :creator => s, :point_value => 1

#Academics & School Readiness
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc22, :name => "Read for 15 minutes", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc22, :name => "Learn a new vocabulary word", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc22, :name => "Practice spelling ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc22, :name => "Read a newspaper article (parent may help) and discuss it", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc23, :name => "Practice writing the alphabet ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc23, :name => "Practice writing words or sentences", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc23, :name => "Practice writing your numbers", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc23, :name => "Write about something your learned today", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc23, :name => "Write a short story", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Complete your math worksheets", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Practice telling time ", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Practice counting money", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Practice addition or subtraction", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Practice multiplication or division", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Use a ruler to measure three things and write down the measurements", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc24, :name => "Do a jigsaw puzzle", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc25, :name => "Draw or color a picture", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc25, :name => "Learn to draw a new object", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc25, :name => "Practice your musical instrument", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc25, :name => "Learn to play a new song", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Bring home all your homework and materials you need", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Start your homework as soon as you get home", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Read homework instructions out loud", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Do homework for at least 10-15 minutes before taking a break", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Complete as much homework as you can on your own", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Turn in your homework on time", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc26, :name => "Organize your binder/folder for class", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc27, :name => "Learn a new word in another language", :creator => s, :point_value => 1
obj = Objective.create :objective_category => oc1, :objective_subcategory => osc27, :name => "Learn a new fact", :creator => s, :point_value => 1


#Awards
ac1 = AwardCategory.create :name => 'Time'
ac1.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'png', :path => '/images/awards/time.png', :remote => true

ac2 = AwardCategory.create :name => 'Money'
ac2.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'png', :path => '/images/awards/money.png', :remote => true

ac3 = AwardCategory.create :name => 'Stuff'
ac3.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'png', :path => '/images/awards/stuff.png', :remote => true

ac4 = AwardCategory.create :name => 'Fun'
ac4.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun.png', :remote => true

aw = Award.create :award_category => ac1, :name => "One hour of Free Time", :description => "Use it wisely!", :point_cost => 10, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'png', :path => '/images/awards/time-hour.png', :remote => true
aw = Award.create :award_category => ac1, :name => "One hour of Video Game Time", :description => "Have Fun!", :point_cost => 10, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'png', :path => '/images/awards/time-video-game.png', :remote => true
aw = Award.create :award_category => ac1, :name => "One hour of TV Time", :description => "Approved shows only", :point_cost => 10, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'png', :path => '/images/awards/time-tv.png', :remote => true
aw = Award.create :award_category => ac1, :name => "One Extra Hour before Bed Time", :description => "Use only on Fridays and weekends", :point_cost => 10, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'time', :format => 'png', :path => '/images/awards/time-bed.png', :remote => true

aw = Award.create :award_category => ac2, :name => "One Dollar", :description => "More stuffing for your piggy bank", :point_cost => 10, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'png', :path => '/images/awards/money-one.png', :remote => true
aw = Award.create :award_category => ac2, :name => "Five Dollars", :description => "More stuffing for your piggy bank", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'png', :path => '/images/awards/money-five.png', :remote => true
aw = Award.create :award_category => ac2, :name => "Ten Dollars", :description => "More stuffing for your piggy bank", :point_cost => 100, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'money', :format => 'png', :path => '/images/awards/money-ten.png', :remote => true

aw = Award.create :award_category => ac3, :name => "New Toy", :description => "Something that you've wanted", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'png', :path => '/images/awards/stuff-toy.png', :remote => true
aw = Award.create :award_category => ac3, :name => "New Video Game", :description => "Something that you've wanted", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'png', :path => '/images/awards/stuff-video-game.png', :remote => true
aw = Award.create :award_category => ac3, :name => "New Clothes", :description => "Something that you've wanted", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'png', :path => '/images/awards/stuff-clothes.png', :remote => true
aw = Award.create :award_category => ac3, :name => "New Book", :description => "Something that you've wanted", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'stuff', :format => 'png', :path => '/images/awards/stuff-new-book.png', :remote => true


aw = Award.create :award_category => ac4, :name => "Trip to Fun Place", :description => "The zoo, the beach, fishing, etc.", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun-place.png', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to Theme Park", :description => "Lots of fun!", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun-theme-park.png', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to a Restaurant", :description => "Let's go out to your favorite restaurant.", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun-restaurant.png', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to the Movies", :description => "Pick a good one!", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun-movies.png', :remote => true
aw = Award.create :award_category => ac4, :name => "Movie Rental", :description => "Pick a good one!", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun-rental.png', :remote => true
aw = Award.create :award_category => ac4, :name => "Trip to a Special Event", :description => "Concert, show, etc.", :point_cost => 50, :creator => s
aw.attachments.create :attachment_type => 'avatar', :name => 'fun', :format => 'png', :path => '/images/awards/fun-event.png', :remote => true


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
