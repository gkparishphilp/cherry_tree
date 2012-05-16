task :cherry_tree_lessons => :environment do
	
	lc1 = LessonCategory.find_by_name 'Academics & School Readiness'
	lc2 = LessonCategory.find_by_name 'Child Behavior & Independence Skills'
	lc3 = LessonCategory.find_by_name 'Social Skills & Emotional Well-Being'
	lc4 = LessonCategory.find_by_name 'Health & Fitness'

	#Roman Numeral Lesson
	l = Lesson.create :name => 'Roman Numerals', :description => 'Learn all about Roman Numerals', :lesson_category => lc1
	s1 = l.screens.create :sequence => 1, :content => "<h1>Roman Numerals</h1><p>Roman numerals are letters of the alphabet that represent numbers.</p><ul><li>I = 1</li><li>V = 5</li><li>X = 10</li><li>L = 50</li><li>C = 100</li><li>D = 500</li><li>M = 1000</li></ul><img src='/images/rn1.png' alt='The Roman Coliseum.'/>"  
	s2 = l.screens.create :sequence => 2, :content => "<h1>The History of Roman Numerals</h1><p>The Roman numerals system dates back over 2,000 years to ancient Rome. Today we usually use Arabic numbers, but you can still see Roman numerals in tables of contents, on some clocks and watches, or as a suffix on a person's name.</p><p>John Smith III</p><img src='/images/rn2.png' alt='An old fashioned clock face.'/>"  
	s3 = l.screens.create :sequence => 3, :content => "<h1>Roman Numerals Rule I</h1><p>I. Repeating a letter repeats its value. A letter can only be repeated up to three times in a row.</p><p>For example:</p><ul><li>III = 3</li><li>XX = 20</li><li>CCC = 300</li></ul>"
	s4 = l.screens.create :sequence => 4, :content => "<h1>Roman Numerals Rule II</h1><p>II. When a letter of lesser value follows one of greater value, add them together.</p><p>For example:</p><ul><li>XI = 10 + 1 = 11</li><li>LVI = 50 + 5 + 1 = 56</li><li>DCCL = 500 + 100 + 100 + 50 = 750 </li></ul>"
	s5 = l.screens.create :sequence => 5, :content => "<h1>Roman Numerals Rule III</h1><p>III. When a letter of lesser value comes before a letter of greater value, subtract the lesser value from the greater value.  Only use I, X or C in this way.</p><p>For example:</p><ul><li>IX = 10 - 1 = 9</li><li>XIX = 10 + (10 - 1) = 10 + 9 = 19</li><li>XCV = 100 - 10 + 5 = 95</li></ul>"

	#Roman Numeral Quiz
	q = l.quizzes.create :name => 'Roman Numeral Quiz', :point_value => 10
	quest = q.questions.create :content => 'Where you can you find Roman numerals today?'
	quest.answers.create :content => 'Table of contents'
	quest.answers.create :content => 'Watch face'
	quest.answers.create :content => 'No place because they have been completely replaced by Arabic numbers.'
	quest.answers.create :content => 'Both (a) and (b).', :correct => true
	quest2 = q.questions.create :content => 'Roman numeral X = '
	quest2.answers.create :content => '1'
	quest2.answers.create :content => '5'
	quest2.answers.create :content => '10', :correct => true
	quest2.answers.create :content => '100'
	quest3 = q.questions.create :content => 'Roman numeral CCC = '
	quest3.answers.create :content => '3'
	quest3.answers.create :content => '30'
	quest3.answers.create :content => '300', :correct => true
	quest3.answers.create :content => '3000'
	quest4 = q.questions.create :content => 'Roman numeral XVII = '
	quest4.answers.create :content => '3'
	quest4.answers.create :content => '13'
	quest4.answers.create :content => '17', :correct => true
	quest4.answers.create :content => '77'
	quest5 = q.questions.create :content => 'Roman numeral LXXXIII = '
	quest5.answers.create :content => '33'
	quest5.answers.create :content => '43'
	quest5.answers.create :content => '65'
	quest5.answers.create :content => '83', :correct => true
	quest6 = q.questions.create :content => 'Roman numeral CM = '
	quest6.answers.create :content => '105'
	quest6.answers.create :content => '500'
	quest6.answers.create :content => '900', :correct => true
	quest6.answers.create :content => '1100'
	quest7 = q.questions.create :content => 'The Arabic number 8 = '
	quest7.answers.create :content => 'VII'
	quest7.answers.create :content => 'VIII', :correct => true
	quest7.answers.create :content => 'IIX'
	quest7.answers.create :content => 'XII'
	quest8 = q.questions.create :content => 'The Arabic number 52 = '
	quest8.answers.create :content => 'VII'
	quest8.answers.create :content => 'XXXXXII'
	quest8.answers.create :content => 'LII', :correct => true
	quest8.answers.create :content => 'LCII'
	quest9 = q.questions.create :content => 'The Arabic number 29 = '
	quest9.answers.create :content => 'XXIX', :correct => true
	quest9.answers.create :content => 'IXXX'
	quest9.answers.create :content => 'XXVIIII'
	quest9.answers.create :content => 'IXXL'
	quest10 = q.questions.create :content => 'The Arabic number 1501 = '
	quest10.answers.create :content => 'XVI'
	quest10.answers.create :content => 'MCI', :correct => true
	quest10.answers.create :content => 'MDI'
	quest10.answers.create :content => 'MMI'


	#Impressionism Lesson
	l = Lesson.create :name => 'Impressionism', :description => 'Learn all about Impressionist Art', :lesson_category => lc1
	s1 = l.screens.create :sequence => 1, :content => "<h1>Before Impressionism</h1><p>For a long time, people judged paintings by how realistic they looked. Artists used dark colors and blended the paint so that their brush strokes would not show. Most paintings were portraits or paintings with historical or religious themes.</p><img src='/images/imp1.png' alt='The famous painting, Mona Lisa.'/>"
	s2 = l.screens.create :sequence => 2, :content => "<h1>The Impressionist Movement</h1><p>In the late 1800s, a group of artists in Paris started painting in a new way. They did not worry as much about making their paintings look realistic. They let their brush strokes show and sometimes even left clumps of color on the canvas. They painted every day scenes with bright colors and reflections of light.</p><img src='/images/imp2.png' alt='An example of an Impressionist Painting, with bright colors and reflections of light.'/>"
	s3 = l.screens.create :sequence => 3, :content => "<h1>Claude Monet</h1><p>Claude Monet is one of the most famous Impressionists. Monet loved to paint 'en plein air' meaning outside 'in the open air.' Impressionism got its name from Monet's painting called <em>Impression, Sunrise</em>.</p><img src='/images/imp3.png' alt='<em>Impression, Sunrise</em> by Claude Monet.'/>"
	s4 = l.screens.create :sequence => 4, :content => "<h1>Edgar Degas</h1><p>Edgar Degas is most well known for his paintings of horses and dancers. Many of these paintings look like snapshots from action scenes.</p><img src='/images/imp4.png' alt='A painting by Edgar Degas.'/>"
	s5 = l.screens.create :sequence => 5, :content => "<h1>Mary Cassatt</h1><p>Mary Cassatt was an American painter. She lived much of her life in Paris and displayed her paintings with the other Impressionists. Cassatt liked to paint her relatives and mothers with children.</p><img src='/images/imp5.png' alt='A painting by Mary Cassatt.'/>"

	#Impressionism Quiz
	q = l.quizzes.create :name => 'Impressionism Quiz', :point_value => 10
	quest = q.questions.create :content => 'Impressionist painters distinguished themselves from traditional artists by painting:'
	quest.answers.create :content => 'with dark colors'
	quest.answers.create :content => 'using well blended brush strokes'
	quest.answers.create :content => 'in indoor art studios'
	quest.answers.create :content => 'every day subject matter ', :correct => true
	quest2 = q.questions.create :content => 'Which artist is NOT associated with Impressionism?'
	quest2.answers.create :content => 'Mary Cassatt'
	quest2.answers.create :content => 'Edgar Degas'
	quest2.answers.create :content => 'Leonardo da Vinci', :correct => true
	quest2.answers.create :content => 'Claude Monet'
	quest3 = q.questions.create :content => 'Which artist was an American Impressionist?'
	quest3.answers.create :content => 'Edgar Degas'
	quest3.answers.create :content => 'Mary Cassatt', :correct => true
	quest3.answers.create :content => 'Pierre-Auguste Renoir'
	quest3.answers.create :content => 'Berthe Morisot'
	quest4 = q.questions.create :content => 'Why was the new style of painting called Impressionism?'
	quest4.answers.create :content => 'Formal art schools were very impressed by the paintings'
	quest4.answers.create :content => 'Monet titled one of his early paintings <em>Impression, Sunrise</em>', :correct => true
	quest4.answers.create :content => 'Brush strokes left impressions on the canvas'
	quest4.answers.create :content => 'All of the above'
	quest5 = q.questions.create :content => 'In which of these paintings can you most easily see different color, distinct brush strokes?'
	quest5.answers.create :content => "<img src='/images/impq51.png' alt='Choice A'/>", :correct => true
	quest5.answers.create :content => "<img src='/images/impq52.png' alt='Choice B'/>"
	quest5.answers.create :content => "<img src='/images/impq53.png' alt='Choice C'/>"
	quest5.answers.create :content => "<img src='/images/impq54.png' alt='Choice D'/>"
	quest6 = q.questions.create :content => 'Which painting was most likely painted "en plein air"?'
	quest6.answers.create :content => "<img src='/images/impq61.png' alt='Choice A'/>", :correct => true
	quest6.answers.create :content => "<img src='/images/impq62.png' alt='Choice B'/>"
	quest6.answers.create :content => "<img src='/images/impq63.png' alt='Choice C'/>"
	quest6.answers.create :content => "<img src='/images/impq64.png' alt='Choice D'/>"
	quest7 = q.questions.create :content => 'Which painting does NOT look like a Claude Monet painting?'
	quest7.answers.create :content => "<img src='/images/impq71.png' alt='Choice A'/>"
	quest7.answers.create :content => "<img src='/images/impq72.png' alt='Choice B'/>"
	quest7.answers.create :content => "<img src='/images/impq73.png' alt='Choice C'/>", :correct => true
	quest7.answers.create :content => "<img src='/images/impq74.png' alt='Choice D'/>"
	quest8 = q.questions.create :content => 'Which painting does NOT look like an Edgar Degas painting?'
	quest8.answers.create :content => "<img src='/images/impq81.png' alt='Choice A'/>"
	quest8.answers.create :content => "<img src='/images/impq82.png' alt='Choice B'/>", :correct => true
	quest8.answers.create :content => "<img src='/images/impq83.png' alt='Choice C'/>"
	quest8.answers.create :content => "<img src='/images/impq84.png' alt='Choice D'/>"
	quest9 = q.questions.create :content => 'Which painting does NOT look like a Mary Cassatt painting?'
	quest9.answers.create :content => "<img src='/images/impq91.png' alt='Choice A'/>", :correct => true
	quest9.answers.create :content => "<img src='/images/impq92.png' alt='Choice B'/>"
	quest9.answers.create :content => "<img src='/images/impq93.png' alt='Choice C'/>"
	quest9.answers.create :content => "<img src='/images/impq94.png' alt='Choice D'/>"
	quest10 = q.questions.create :content => 'Which of these Impressionist paintings do you like best?  HINT: There is no wrong answer!'
	quest10.answers.create :content => "<img src='/images/impq101.png' alt='Choice A'/>", :correct => true
	quest10.answers.create :content => "<img src='/images/impq102.png' alt='Choice B'/>", :correct => true
	quest10.answers.create :content => "<img src='/images/impq103.png' alt='Choice C'/>", :correct => true
	quest10.answers.create :content => "<img src='/images/impq104.png' alt='Choice D'/>", :correct => true

	#Communication Lesson
	l = Lesson.create :name => 'Communication', :description => 'Learn all about the power of good communication.', :lesson_category => lc3
	s1 = l.screens.create :sequence => 1, :content => "<p>Communication is a way to let others know what you want and need, and to understand what they want and need. It is important to learn to properly communicate with your friends and family. Take this quiz to learn how you should communicate with others in different scenarios.</p>"  

	#Communication Quiz
	q = l.quizzes.create :name => 'Communication Quiz', :point_value => 10
	quest = q.questions.create :content => '<img src="/images/comm1.png" alt="Talking to someone"/><p>What should you do when talking to someone?<p>'
	quest.answers.create :content => 'Look at the person.'
	quest.answers.create :content => 'Use a pleasant voice.'
	quest.answers.create :content => 'Speak Clearly.'
	quest.answers.create :content => 'All of the above.', :correct => true
	quest2 = q.questions.create :content => '<img src="/images/comm2.png" alt="I will not interrupt them."/><p>Why is it wrong to interrupt someone who is speaking to you?</p>'
	quest2.answers.create :content => 'They may interrupt you.'
	quest2.answers.create :content => 'It shows poor eye contact.'
	quest2.answers.create :content => "It shows that you don't care.", :correct => true
	quest2.answers.create :content => "They won't listen to you later."
	quest3 = q.questions.create :content => '<img src="/images/comm3.png" alt="Emotional Megaphone!"/><p>What should you NOT do when having a conversation?</p>'
	quest3.answers.create :content => 'Use a calm pleasant voice tone. '
	quest3.answers.create :content => 'Speak in a loud harsh tone.', :correct => true
	quest3.answers.create :content => "Make eye contact."
	quest3.answers.create :content => "Speak slowly."
	quest4 = q.questions.create :content => '<img src="/images/comm4.png" alt="Leapfrog"/><p>When someone is talking to you about a specific topic...</p>'
	quest4.answers.create :content => 'shout, whine, and beg. '
	quest4.answers.create :content => 'stay on that topic. ', :correct => true
	quest4.answers.create :content => "interrupt frequently."
	quest4.answers.create :content => "walk away in the middle of the conversation."
	quest5 = q.questions.create :content => '<img src="/images/comm5.png" alt="Good conversation."/><p>How should you look when having a conversation with someone?</p>'
	quest5.answers.create :content => 'Fidgety and restless.'
	quest5.answers.create :content => 'Upset and angry.'
	quest5.answers.create :content => "Calm and relaxed.", :correct => true
	quest5.answers.create :content => "Uninterested and bored."
	quest6 = q.questions.create :content => '<img src="/images/comm6.png" alt="Phone call during dinner."/><p>If someone close to you calls you in the middle of dinner, what should you tell the caller?</p>'
	quest6.answers.create :content => 'Talk to them without mentioning that you were in the middle of dinner.'
	quest6.answers.create :content => 'Abruptly tell them you are in the middle of dinner'
	quest6.answers.create :content => "Try to get them to hang up as soon as possible"
	quest6.answers.create :content => "Explain that you are at dinner and will call them back as soon as possible.", :correct => true
	quest7 = q.questions.create :content => '<img src="/images/comm7.png" alt="Ants cutting in line..."/><p>Someone cuts in front of you in a line. You:</p>'
	quest7.answers.create :content => "Assume they didn't realize you were in line, and gently explain to them that you were waiting before them.", :correct => true
	quest7.answers.create :content => "Tell them you don't appreciate their behavior and that they need to return to their proper place."
	quest7.answers.create :content => "Say nothing."
	quest7.answers.create :content => "Say nothing, but glare at them and <em>accidentally</em> push them a little."
	quest8 = q.questions.create :content => '<img src="/images/comm8.png" alt="Cartoon yelling..."/><p>If you get into an argument, you should:</p>'
	quest8.answers.create :content => 'Push the other person until they agree with you'
	quest8.answers.create :content => "Try to understand the other person's point of view and try to find a way to get you both what you want.", :correct => true
	quest8.answers.create :content => "Just end the argument quickly, even if it means telling the other person they are right."
	quest8.answers.create :content => "Be as loud as possible and make sure the other person agrees with you."
	quest9 = q.questions.create :content => '<img src="/images/comm9.png" alt="teasing"/><p>If someone is making fun of you, you should:</p>'
	quest9.answers.create :content => "Tell them you don't appreciate the jokes and ask them to stop, and if the jokes don't stop, you should tell a teacher.", :correct => true
	quest9.answers.create :content => "Make fun of them back."
	quest9.answers.create :content => "Tell the teacher right away and demand they be punished."
	quest9.answers.create :content => "Say nothing. You don't want to make things worse."
	quest10 = q.questions.create :content => '<img src="/images/comm10.png" alt="Running late"/><p>Your mom is making you late to practice. You should:</p>'
	quest10.answers.create :content => "Say nothing... she might not give you a treat after dinner."
	quest10.answers.create :content => "Ask her if you can help her with something so that you can get to practice on time.", :correct => true
	quest10.answers.create :content => "Yell at her for being late all the time."
	quest10.answers.create :content => "Tell her that you really don't appreciate being late, and that you think her behavior is very rude."

	#Emotions Lesson
	l = Lesson.create :name => 'Emotions', :description => "Learn how to recognize emotions in other people's faces.", :lesson_category => lc3
	s1 = l.screens.create :sequence => 1, :content => "<p>They say that it takes 43 muscles to frown and only 17 muscles to smile. Someone's facial expressions can tell us a lot about how they are feeling. This quiz will teach you to recognize certain emotions from a person's facial expressions.</p>"  

	#Emotions Quiz
	#not sure about the correct answers 
	q = l.quizzes.create :name => 'Emotions Quiz', :point_value => 10
	quest = q.questions.create :content => '<img src="/images/emo1.png" alt="Face 1"/><p>This face is expressing...<p>'
	quest.answers.create :content => 'Embarrassment'
	quest.answers.create :content => 'Fear', :correct => true
	quest.answers.create :content => 'Sadness'
	quest.answers.create :content => 'Surprise'
	quest2 = q.questions.create :content => '<img src="/images/emo2.png" alt="Face 2"/><p>This face is expressing...<p>'
	quest2.answers.create :content => 'Flirtatiousness'
	quest2.answers.create :content => 'Interest'
	quest2.answers.create :content => 'Happiness', :correct => true
	quest2.answers.create :content => 'Politeness'
	quest3 = q.questions.create :content => '<img src="/images/emo3.png" alt="Face 3"/><p>This face is expressing...<p>'
	quest3.answers.create :content => 'Sadness'
	quest3.answers.create :content => 'Pain'
	quest3.answers.create :content => 'Anger', :correct => true
	quest3.answers.create :content => 'Disgust'
	quest4 = q.questions.create :content => '<img src="/images/emo4.png" alt="Face 4"/><p>This face is expressing...<p>'
	quest4.answers.create :content => 'Embarrassment'
	quest4.answers.create :content => 'Sadness'
	quest4.answers.create :content => 'Amusement', :correct => true
	quest4.answers.create :content => 'Shame'
	quest5 = q.questions.create :content => '<img src="/images/emo5.png" alt="Face 5"/><p>This face is expressing...<p>'
	quest5.answers.create :content => 'Pride', :correct => true
	quest5.answers.create :content => 'Contempt'
	quest5.answers.create :content => 'Excitement'
	quest5.answers.create :content => 'Anger'
	quest6 = q.questions.create :content => '<img src="/images/emo6.png" alt="Face 6"/><p>This face is expressing...<p>'
	quest6.answers.create :content => 'Fear'
	quest6.answers.create :content => 'Interest'
	quest6.answers.create :content => 'Surprise', :correct => true
	quest6.answers.create :content => 'Compassion'
	quest7 = q.questions.create :content => '<img src="/images/emo7.png" alt="Face 7"/><p>This face is expressing...<p>'
	quest7.answers.create :content => 'Sadness'
	quest7.answers.create :content => 'Shame'
	quest7.answers.create :content => 'Disgust'
	quest7.answers.create :content => 'Contempt', :correct => true
	quest8 = q.questions.create :content => '<img src="/images/emo8.png" alt="Face 8"/><p>This face is expressing...<p>'
	quest8.answers.create :content => 'Anger'
	quest8.answers.create :content => 'Pain'
	quest8.answers.create :content => 'Disgust', :correct => true
	quest8.answers.create :content => 'Sadness'
	quest9 = q.questions.create :content => '<img src="/images/emo9.png" alt="Face 9"/><p>This face is expressing...<p>'
	quest9.answers.create :content => 'Shame'
	quest9.answers.create :content => 'Anger'
	quest9.answers.create :content => 'Sadness', :correct => true
	quest9.answers.create :content => 'Pain'
	quest10 = q.questions.create :content => '<img src="/images/emo10.png" alt="Face 10"/><p>This face is expressing...<p>'
	quest10.answers.create :content => 'Amusement', :correct => true
	quest10.answers.create :content => 'Desire'
	quest10.answers.create :content => 'Surprise'
	quest10.answers.create :content => 'Excitment'

	#Being a Good Friend Lesson
	l = Lesson.create :name => 'Being a Good Friend', :description => "Learn how to be a good friend.", :lesson_category => lc3
	s1 = l.screens.create :sequence => 1, :content => "<h1>Being a Good Friend</h1><p>Being a good friend means you are helpful and kind to the people that you care about- no matter what! A good friend likes you because of who you are inside and not for what you look like on the outside. You can be a good friend by being helpful to your friends each and every day.</p>"  

	#Friendship Quiz
	q = l.quizzes.create :name => 'Friendship Quiz', :point_value => 10
	quest = q.questions.create :content => '<img src="/images/fr1.png" alt="Lunchbox"/><p>When you sit down at lunch with your friend, what should you do?<p>'
	quest.answers.create :content => "Don't say much, just eat and run"
	quest.answers.create :content => "Spend the whole time talking."
	quest.answers.create :content => "Ask questions and spend equal time talking.", :correct => true
	quest.answers.create :content => "Let your friend talk, and just listen."
	quest2 = q.questions.create :content => '<img src="/images/fr2.png" alt="Teasing"/><p>Someone is making fun of your best friend. What should you do?<p>'
	quest2.answers.create :content => "Join them and make of him."
	quest2.answers.create :content => "Say nothing."
	quest2.answers.create :content => "Tell them to stop it.", :correct => true
	quest2.answers.create :content => "Make fun of them."
	quest3 = q.questions.create :content => '<img src="/images/fr3.png" alt="Standing in line"/><p>You really wanted to be line leader today but your friend is chosen instead. What should you do?<p>'
	quest3.answers.create :content => "Say 'congratulations' and be happy for him.", :correct => true
	quest3.answers.create :content => "Be mad at him and ignore him."
	quest3.answers.create :content => "Throw a fit."
	quest3.answers.create :content => "Complain to the teacher that you should have been chosen."
	quest4 = q.questions.create :content => '<img src="/images/fr4.png" alt="Show and tell"/><p>You tell your friend that you are going to bring a Barbie doll to show &amp; tell. Next thing you know she brings the same Barbie doll to show & tell. What should you do?<p>'
	quest4.answers.create :content => "Yell at her for copying you and tell her to find a new friend."
	quest4.answers.create :content => "Tell your friend you are disappointed, but let her go first."
	quest4.answers.create :content => "Tell your friend you are disappointed, and ask to go first.", :correct => true
	quest4.answers.create :content => "Tell the teacher that she copied you and shouldn't get to present to the class."
	quest5 = q.questions.create :content => "<img src='/images/fr5.png' alt='Hurt my arm'/><p>You hurt your arm, and your friend didn't ask you if you were ok. The next day she hurts her arm. What should you do?<p>"
	quest5.answers.create :content => "Don't ask if she is ok."
	quest5.answers.create :content => "Laugh at her."
	quest5.answers.create :content => "Tell her you're glad she hurt her arm."
	quest5.answers.create :content => "Ask her if he is ok and see if she needs help.", :correct => true
	quest6 = q.questions.create :content => '<img src="/images/fr6.png" alt="Basketball hoop"/><p>You and PJ made plans to play at the park. Then Brian calls and invites you to come over and play basketball. You love basketball. What should you do?<p>'
	quest6.answers.create :content => "Cancel your plans with PJ and go play basketball with Brian"
	quest6.answers.create :content => "Don't tell PJ anything, and go play basketball with Brian"
	quest6.answers.create :content => "Thank Brian, but tell him that you already have plans to play with PJ", :correct => true
	quest6.answers.create :content => "Tell Brian that you don't like basketball."
	quest7 = q.questions.create :content => '<img src="/images/fr7.png" alt="Juggling Clown"/><p>You are having a birthday party and you want to have a clown there. Your friend Sara is scared of clowns. What should you do?<p>'
	quest7.answers.create :content => "Don't invite Sara"
	quest7.answers.create :content => "Invite Sara and don't tell her about the clown and hope she'll be ok"
	quest7.answers.create :content => "Invite Sara, but tell her about the clown and help her not be afraid.", :correct => true
	quest7.answers.create :content => "Make fun of Sara because she is afraid of clowns."
	quest8 = q.questions.create :content => "<img src='/images/fr8.png' alt='Playing with toy truck'/><p>Your friend borrows your toy. When he brings it back, he doesn't tell you that one of the wheels is broken. What should you do?<p>"
	quest8.answers.create :content => "Scream at him for breaking the wheel."
	quest8.answers.create :content => "Ask him calmly what happened, maybe there is a good explanation.", :correct => true
	quest8.answers.create :content => "Don't say anything, but borrow one of his toys and break it."
	quest8.answers.create :content => "Tell everyone to not let him borrow toys."
	quest9 = q.questions.create :content => '<img src="/images/fr9.png" alt="Babies"/><p>You see your friend crying. What should you do?<p>'
	quest9.answers.create :content => "Nothing. It's embarrassing to cry in front of people."
	quest9.answers.create :content => "Tell them it's ok, and find out what's wrong.", :correct => true
	quest9.answers.create :content => "Find out what's wrong and then decide if it's worth spending time helping them."
	quest9.answers.create :content => "Tell them to toughen up."
	quest10 = q.questions.create :content => "<img src='/images/fr10.png' alt='Birthday!'/><p>It's your best friend's birthday and you forgot. What should you do?:<p>"
	quest10.answers.create :content => "Act like you remembered but forgot her card or present at home."
	quest10.answers.create :content => "Avoid her all day so she doesn't know you forgot."
	quest10.answers.create :content => "Tell her you don't celebrate birthdays."
	quest10.answers.create :content => "Tell her the truth, and promise to make it up to her.", :correct => true


	# Displaying Self Control Lesson
	l = Lesson.create :name => 'Displaying Self Control', :description => "Learn how to control yourself when things don't go as planned.", :lesson_category => lc3
	s1 = l.screens.create :sequence => 1, :content => "<h1>Displaying Self Control</h1><p>Sometimes things happen that make us upset and angry. When that happens, we have to choose how we deal with our problems. Self-control is the ability to remain rational and in-control even when the situation becomes very stressful and problematic. Self-control can vary between two opposite points: impulsiveness (total lack of self-control) and rationality (calmness and absence of emotions). The following quiz will present various scenarios and options of how to react and display self-control.</p>"  


	# Displaying Self Control Quiz
	q = l.quizzes.create :name => 'Displaying Self Control Quiz', :point_value => 10
	quest = q.questions.create :content => "<img src='/images/sc1.png' alt='Bag over head'/><p>You do something embarrassing in front of your class, how do you behave afterwards?<p>"
	quest.answers.create :content => "Try to avoid everyone."
	quest.answers.create :content => "Make up an excuse for what you did."
	quest.answers.create :content => "Laugh with them about it.", :correct => true
	quest.answers.create :content => "Get upset and cry."
	quest2 = q.questions.create :content => "<img src='/images/sc2.png' alt='Distracted'/><p>You get distracted and drop your books on the ground, what's your first reaction?<p>"
	quest2.answers.create :content => "You get angry."
	quest2.answers.create :content => "You pick your books up and move on.", :correct => true
	quest2.answers.create :content => "You walk away and leave the books."
	quest2.answers.create :content => "You begin to tear up."
	quest3 = q.questions.create :content => '<img src="/images/sc3.png" alt="Spilled drink"/><p>Your brother runs into you and spills your drink on your shirt, what do you do?<p>'
	quest3.answers.create :content => "Yell at him."
	quest3.answers.create :content => "Push him."
	quest3.answers.create :content => "Pour the rest of your drink on him."
	quest3.answers.create :content => "Accept his apology (or ask him to apologize if he didn't) and go clean yourself up.", :correct => true
	quest4 = q.questions.create :content => "<img src='/images/sc4.png' alt='Soccer game'/><p>You're playing Soccer and someone accidentally trips you, what do you do?<p>"
	quest4.answers.create :content => "Jump up and push them."
	quest4.answers.create :content => "Get up and let the referee take care of it.", :correct => true
	quest4.answers.create :content => "Complain at the top of your lungs."
	quest4.answers.create :content => "Walk off the field."
	quest5 = q.questions.create :content => '<img src="/images/sc5.png" alt="Disagreement"/><p>When you disagree with someone, you should:<p>'
	quest5.answers.create :content => "Raise your voice."
	quest5.answers.create :content => "Get angry and shout."
	quest5.answers.create :content => "Get physical."
	quest5.answers.create :content => "Remain calm and respectful.", :correct => true
	quest6 = q.questions.create :content => '<img src="/images/sc6.png" alt="Broken toy"/><p>You come home and find your toy is broken, what should you do?<p>'
	quest6.answers.create :content => "Accuse the first person you see."
	quest6.answers.create :content => "Get frustrated and yell at someone."
	quest6.answers.create :content => "Try and fix the toy or ask a Parent for help", :correct => true
	quest6.answers.create :content => "Throw the toy away."
	quest7 = q.questions.create :content => '<img src="/images/sc7.png" alt="Teasing"/><p>If someone is making fun of you, you should:<p>'
	quest7.answers.create :content => "Tell them you don't appreciate the jokes and ask them to stop.", :correct => true
	quest7.answers.create :content => "Start a fight"
	quest7.answers.create :content => "Make fun of them back"
	quest7.answers.create :content => "Throw something at them"
	quest8 = q.questions.create :content => '<img src="/images/sc8.png" alt="Ants cut in line"/><p>Someone cuts in front of you in a line. You:<p>'
	quest8.answers.create :content => "Assume they didn't realize you were in line, and gently explain to them that you were waiting before them.", :correct => true
	quest8.answers.create :content => "Say something mean to them."
	quest8.answers.create :content => "Yell at them to get to the back of the line."
	quest8.answers.create :content => "Take them by the arm and walk them to the back of the line"
	quest9 = q.questions.create :content => '<img src="/images/sc9.png" alt="Friend falls over"/><p>Your friend falls and is badly hurt. What should you do?<p>'
	quest9.answers.create :content => "Panic and leave."
	quest9.answers.create :content => "Immediately get help.", :correct => true
	quest9.answers.create :content => "Take your time to evaluate the situation."
	quest9.answers.create :content => "Tell him how irresponsible he was."
	quest10 = q.questions.create :content => '<img src="/images/sc10.png" alt="Mom running around"/><p>Your mom is making you late to practice. You should:<p>'
	quest10.answers.create :content => "Ask her if you can help her with something so that you can get to practice on time.", :correct => true
	quest10.answers.create :content => "Throw your things on the floor and refuse to go."
	quest10.answers.create :content => "Yell at her for being late all the time."
	quest10.answers.create :content => "Tell her that you really don't appreciate being late, and that you think her behavior is very rude."

	# Patience Lesson
	l = Lesson.create :name => 'Patience', :description => "Learn how to be patient", :lesson_category => lc2
	s1 = l.screens.create :sequence => 1, :content => "<h1>Patience</h1><p>Patience is showing a positive reaction even in a difficult circumstance. To be patient, you must first think before you act. This give you time to settle things out in an orderly manner.</p><p>There are many benefits to being patient.  It will make you into a friendly and successful person, allow you to avoid feelings of frustration, and help you cope when things don't go as you plan.</p><p>Patience also helps manage anger. When you are patient, you will be able to control your feeling of disappointment, embarrassment and hatred. You will be able to turn those situations into positive ones.</p>"  


	# Patience Lesson
	q = l.quizzes.create :name => 'Patience', :point_value => 10
	quest = q.questions.create :content => "<img src='/images/p1.png' alt='Spilled glass'/><p>While having a meal, your brother or sister accidentally spills something over you. Which of these should you NOT do?<p>"
	quest.answers.create :content => "Tell him not to worry about it, as you know it was an accident."
	quest.answers.create :content => "Yell at them and call them a name.", :correct => true
	quest.answers.create :content => "Count to ten before saying anything."
	quest.answers.create :content => "Get up calmly from your chair and then go and clean your clothes in the rest room."
	quest2 = q.questions.create :content => "<img src='/images/p2.png' alt='Talks too much'/><p>Your teacher asks you to do a project with another student that you think talks too much. Which of these should you NOT do?<p>"
	quest2.answers.create :content => "Treat them well at all times."
	quest2.answers.create :content => "Tell them to be quiet and give you some peace and quiet.", :correct => true
	quest2.answers.create :content => "Try to ignore their constant talking."
	quest2.answers.create :content => "Give them some busy work to do, so that you can get on with yours in peace."
	quest3 = q.questions.create :content => "<img src='/images/p3.png' alt='Remote'/><p>Your grandpa can't figure out how to use the remote to turn the TV on. You should...<p>"
	quest3.answers.create :content => "Take the remote and turn it on yourself, as you haven't got time for any questions."
	quest3.answers.create :content => "Explain how to use the remote once, but if they don't get it tell them to just ask someone when they need help."
	quest3.answers.create :content => "Explain how to use the remote, and keep going over it until they understand.", :correct => true
	quest3.answers.create :content => "Tell them the remote is broken (even though it's not)."
	quest4 = q.questions.create :content => "<img src='/images/p4.png' alt='Karate'/><p>You have karate practice, but when it is time to go your mom isn't ready. You should...<p>"
	quest4.answers.create :content => "Ask your mom why she didn't get ready earlier, like you did."
	quest4.answers.create :content => "Wait a little longer for her, and then try to hurry her up."
	quest4.answers.create :content => "Scream at her, and then say that you are not going if she is late one more minute."
	quest4.answers.create :content => "Wait patiently until she is ready.", :correct => true
	quest5 = q.questions.create :content => "<img src='/images/p5.png' alt='TV'/><p>Your favorite TV show freezes right in the middle of watching it. Which of these should you NOT do?<p>"
	quest5.answers.create :content => "Switch the TV off and hope that it will be ok when you switch it back on."
	quest5.answers.create :content => "Feel cross about it, but decide that getting annoyed will only make the situation worse."
	quest5.answers.create :content => "Scream at it and shake it.", :correct => true
	quest5.answers.create :content => "Take a couple of minutes to decide what the best thing to do is."
	quest6 = q.questions.create :content => "<img src='/images/p6.png' alt='Bored'/><p>You finished your work and your desk is clear, but someone in your group has not and your teacher won't dismiss your group for recess until everyone is done.<p>"
	quest6.answers.create :content => "You get angry, and tell that person to hurry up"
	quest6.answers.create :content => "You wait as long as it takes for that person to be done, or offer to help them.", :correct => true
	quest6.answers.create :content => "You finish their work for them and clear their desk."
	quest6.answers.create :content => "You tell the teacher that its not fair you have to wait for others."
	quest7 = q.questions.create :content => "<img src='/images/p7.png' alt='Waiting In line'/><p>You've been waiting for a while to play with a toy, but the person playing with it is not giving you a turn. What should you do?<p>"
	quest7.answers.create :content => "Go and ask the teacher to give you the toy."
	quest7.answers.create :content => "Ask them how much longer they will be, and make a decision if you want to wait or go play with something else and come back.", :correct => true
	quest7.answers.create :content => "Get frustrated and walk away."
	quest7.answers.create :content => "Look at your watch and just hope that you won't have to wait too much longer."
	quest8 = q.questions.create :content => "<img src='/images/p8.png' alt='Talking on the phone'/><p>You want to tell your mother something but she is on the phone. You should?<p>"
	quest8.answers.create :content => "Tug and pull at her shirt to get her attention."
	quest8.answers.create :content => "Yell so she can hear you over her conversation "
	quest8.answers.create :content => "Stay calm and wait for her to finish so that you can tell her.", :correct => true
	quest8.answers.create :content => "Decide you are not going to tell her because she isn't listening to you."
	quest9 = q.questions.create :content => "<img src='/images/p9.png' alt='Baby sucking on toy'/><p>If you find your baby brother sucking on your toy, you should<p>"
	quest9.answers.create :content => "Yell at him to stop."
	quest9.answers.create :content => "Tear the toy out of his hands."
	quest9.answers.create :content => "Calmly take the toy out of his mouth.", :correct => true
	quest9.answers.create :content => "Do nothing and wait until he puts the toy down."
	quest10 = q.questions.create :content => "<img src='/images/p10.png' alt='Playing goalie'/><p>You really want to play goalie in your soccer game and the coach told you that you would get the chance at your next game. But when your next game came up, he didn't put you at goalie.  You should:<p>"
	quest10.answers.create :content => "Say nothing and hope he remembers next week."
	quest10.answers.create :content => "Throw a fit and refuse to play."
	quest10.answers.create :content => "Play the position coach gave you but remind him that you would like to play goalie.", :correct => true
	quest10.answers.create :content => "Assume coach just doesn't think you would be good at goalie."


	# Exercise Challenge
	l = Lesson.create :name => 'Exercise Challenge', :description => "Learn some exercises!", :lesson_category => lc4
	s1 = l.screens.create :sequence => 1, :content => "<h1>Exercise Challenege</h1><p>Physical activity is good for you!  It can help you have stronger muscles and bones and a healthier heart.  Exercise can also help you have more energy, more confidence, a better memory, and just feel all around good.  Try these 10 exercises!</p>"  
	s2 = l.screens.create :sequence => 2, :content => "<h1>Groovy Warm Up</h1><p>Dance to your favorite song.  If you can't play it right now, sing it while you dance.</p><img src='/images/ec1.png' alt='Dance'/>"  
	s3= l.screens.create :sequence => 3, :content => "<h1>Upper Body Stretch</h1><p>Stretch your right arm across your body and count to 20.</p><p>Stretch your left arm across your body and count to 20.</p><img src='/images/ec2.png' alt='Stretch arms'/>"  
	s4 = l.screens.create :sequence => 4, :content => "<h1>Lower Body Stretch</h1><p>Sit on the ground with your legs in a straddle.  Reach for your right foot and count to 20.</p><p>Reach for your left foot and count to 20.</p><p>Reach for the middle and count to 20.</p><img src='/images/ec3.png' alt='Stretch legs'/>"  
	s5 = l.screens.create :sequence => 5, :content => "<h1>Butterfly Yoga Pose</h1><p>Sit on the floor with your knees bent and the bottoms of your feet together.  Grab your feet, push your knees to the ground and sit up nice and straight.  Breathe in and out slowly while you feel the stretch in your legs and back.</p><img src='/images/ec4.png' alt='Stretch Back'/>"  
	s6 = l.screens.create :sequence => 6, :content => "<h1>Bow Yoga Pose</h1><p>Lie on your tummy.  Bend your knees and grab your ankles behind you.  Take a deep breath in while you lift your head and chest and legs off of the floor.  Feel the stretch in your back and tummy.  When you are ready, breathe out and lie back down slowly.</p><img src='/images/ec5.png' alt='Bow yoga'/>"  
	s7 = l.screens.create :sequence => 7, :content => "<h1>Heart Workout</h1><p>Pick an activity that will get your heart rate going, and do it for at least 5 minutes.  You could  jog, skip, jump rope, do jumping jacks, dance around, or ride your bike or scooter.</p><img src='/images/ec6.png' alt='Heart rate activity'/>"  
	s8 = l.screens.create :sequence => 8, :content => "<h1>Squat Jumps</h1><p>Start in a squat with your hands on the ground.  From the squat position, jump as high as you can with your hands over your head.  Do this 10 times.</p><img src='/images/ec7-1.png' alt='Squat'/><img src='/images/ec7-2.png' alt='Jump'/>"  
	s9 = l.screens.create :sequence => 9, :content => "<h1>Push Ups</h1><p>Start in a push up position, facing down with your hands and toes on the ground, and your back nice and straight.  Complete 10 push ups.</p><img src='/images/ec8.png' alt='Pushups'/>"  
	s10 = l.screens.create :sequence => 10, :content => "<h1>Stomach Curls</h1><p>Sit with your knees bent and your toes tucked under a couch or chair.  Lie down and cross your arms across your chest.  Do 25 sit-sups.</p><img src='/images/ec9.png' alt='Situps'/>"  
	s11 = l.screens.create :sequence => 11, :content => "<h1>Cool Down and Rehydrate</h1><p>Repeat your favorite stretching exercises.  Drink a glass of water.  You did it!</p><img src='/images/ec10.png' alt='Done!'/>"  

	#Motor Skills Challenge
	l = Lesson.create :name => 'Motor Skills Challenge', :description => "Learn some good motor skills!", :lesson_category => lc4
	s1 = l.screens.create :sequence => 1, :content => "<h1>Motor Skills Challenge</h1><p>Motor skills are the strength, flexibility and balancing skills that help your body move and do fun things.  Try these 10 exercises!</p>"  
	s2 = l.screens.create :sequence => 2, :content => "<h1>Stand Tall</h1><p>Reach your hands as high as you can and stand on your tippy toes while you count to 10.</p><img src='/images/ms1.png' alt='Stand tall!'/>"  
	s3= l.screens.create :sequence => 3, :content => "<h1>Toe Touch</h1><p>Stand with your legs straight and reach for your toes while you count to 10.</p><img src='/images/ms2.png' alt='Toe touch'/>"  
	s4 = l.screens.create :sequence => 4, :content => "<h1>Bunny Jumps</h1><p>Jump up and down 10 times.</p><p>Reach for the middle and count to 20.</p><img src='/images/ms3.png' alt='Bunny Jumps'/>"  
	s5 = l.screens.create :sequence => 5, :content => "<h1>Straddle Sits</h1><p>Sit on the ground with your legs apart in a straddle.  Reach forward and count to 10.</p><img src='/images/ms4.png' alt='Straddle Sit'/>"  
	s6 = l.screens.create :sequence => 6, :content => "<h1>Make a Table</h1><p>Sit on the floor with your knees tucked in front of you and hands behind you.  Push your tummy up to make a table.</p><img src='/images/ms5.png' alt='Make a table'/>"  
	s7 = l.screens.create :sequence => 7, :content => "<h1>Palm Push</h1><p>Stand with the palms of your hands together.  Push your palms together as hard as you can while you count to 10.</p><img src='/images/ms6.png' alt='Palm Push'/>"  
	s8 = l.screens.create :sequence => 8, :content => "<h1>Lazy 8's</h1><p>A Lazy 8 is the number 8 on its side.  Use your right hand to draw 5 Lazy 8's in the air in front of you.  Then use your left hand to draw 5 Lazy 8's in the air in front of you.</p><img src='/images/ms7.png' alt='Lazy 8s'/>"  
	s9 = l.screens.create :sequence => 9, :content => "<h1>Heel to Toe Walk</h1><p>Walk across the room in a straight line.  When you take a step with one foot, put your heel right in front of your toes on the other foot.</p><img src='/images/ms8.png' alt='Heel to Heel Walk'/>"  
	s10 = l.screens.create :sequence => 10, :content => "<h1>Pencil Roll</h1><p>Lie down on the floor with your arms by your side.  Roll in one direction, then roll in the other direction.</p><img src='/images/ms9.png' alt='Pencil Walk'/>"  
	s11 = l.screens.create :sequence => 11, :content => "<h1>Book Jump</h1><p>Place a book on the ground.  Practice jumping over the book without touching it.  Do this 5 times.  </p><img src='/images/ms10.png' alt='Book jump'/>"  

	#Rhyming Lesson
	l = Lesson.create :name => 'Rhyming', :description => 'Learn all about rhymes.', :lesson_category => lc1
	s1 = l.screens.create :sequence => 1, :content => "<h1>Rhyming</h1><p>Words with endings that sound the same rhyme!</p><ul><li><u>BAT</u> rhymes with <u>CAT</u></li><li><u>FAN</u> rhymes with <u>MAN</u></li><li><u>NEST</u> rhymes with <u>BEST</u></li></ul>"  
	s2 = l.screens.create :sequence => 2, :content => '<h1>Rhymes in Poems</h1><p>Lots of poems use rhymes.</p><p>Joyce Kilmer wrote a famous poem called <em>Trees</em> that starts out "I think that I shall never <u>SEE</u>, a poem lovely as a <u>TREE</u>."'  
	s3 = l.screens.create :sequence => 3, :content => '<h1>Rhymes in Songs</h1><p>Lots of songs use rhymes too.</p><p>"Twinkle, twinkle little <u>STAR</u>,  How I wonder what you <u>ARE</u>."</p><p>Keep singing, and notice all the rhyming words!</p>'  
	s4 = l.screens.create :sequence => 4, :content => '<h1>Nursery Rhymes</h1><p>You can find lots of rhyming words in nursery rhymes that you know.  For example:</p><p>"Jack and <u>JILL</u> went up the <u>HILL</u>."</p><p>"Little Miss <u>MUFFET</u> sat on a <u>TUFFET</u>."</p><p>"Old King <u>COLE</u> was a merry old <u>SOLE</u>."</p>'  

	#Rhyming Quiz
	q = l.quizzes.create :name => 'Rhyming Quiz', :point_value => 10
	quest = q.questions.create :content => 'Which of these words best rhymes with <u>POT</u>:'
	quest.answers.create :content => 'PIN'
	quest.answers.create :content => 'PAN'
	quest.answers.create :content => 'DOT', :correct => true
	quest.answers.create :content => 'DOG'
	quest2 = q.questions.create :content => 'Which of these words best rhymes with <u>DOG</u>:'
	quest2.answers.create :content => 'DIG'
	quest2.answers.create :content => 'FROG', :correct => true
	quest2.answers.create :content => 'BONE'
	quest2.answers.create :content => 'CAT'
	quest3 = q.questions.create :content => 'Which of these words best rhymes with <u>WATER</u>:'
	quest3.answers.create :content => 'DRINK'
	quest3.answers.create :content => 'HOTTER', :correct => true
	quest3.answers.create :content => 'BATTER'
	quest3.answers.create :content => 'FLOWER'
	quest4 = q.questions.create :content => 'Which of these words does not rhyme with the others in the list:'
	quest4.answers.create :content => 'FAN'
	quest4.answers.create :content => 'RAN'
	quest4.answers.create :content => 'RUN', :correct => true
	quest4.answers.create :content => 'CAN'
	quest5 = q.questions.create :content => 'Which of these words does not rhyme with the others in the list:'
	quest5.answers.create :content => 'TALL'
	quest5.answers.create :content => 'FALL'
	quest5.answers.create :content => 'FELL', :correct => true
	quest5.answers.create :content => 'MALL'
	quest6 = q.questions.create :content => 'Which of these words does not rhyme with the others in the list:'
	quest6.answers.create :content => 'SEND', :correct => true
	quest6.answers.create :content => 'MEN'
	quest6.answers.create :content => 'AGAIN'
	quest6.answers.create :content => 'WREN'
	quest7 = q.questions.create :content => 'Which pair of words rhymes:'
	quest7.answers.create :content => 'FISH and DISH', :correct => true
	quest7.answers.create :content => 'OVER and UNDER'
	quest7.answers.create :content => 'BALL and BELL'
	quest7.answers.create :content => 'ATE and EAT'
	quest8 = q.questions.create :content => 'Which pair of words rhymes:'
	quest8.answers.create :content => 'TALL and SHORT'
	quest8.answers.create :content => 'SMALL and SMELL'
	quest8.answers.create :content => 'CLEAN and GREEN', :correct => true
	quest8.answers.create :content => 'SMILE and WHALE'
	quest9 = q.questions.create :content => 'Which pair of words rhymes:'
	quest9.answers.create :content => 'SKY and CLOUDS'
	quest9.answers.create :content => 'PLANE and RAIN', :correct => true
	quest9.answers.create :content => 'BLUE and BERRY'
	quest9.answers.create :content => 'TOO and TEA'
	quest10 = q.questions.create :content => 'Which word best rhymes with <u>ORANGE:</u>'
	quest10.answers.create :content => 'GRAPE'
	quest10.answers.create :content => 'YELLOW'
	quest10.answers.create :content => 'JUICE'
	quest10.answers.create :content => "It's a trick question! Nothing rhymes with orange!", :correct => true

end

















