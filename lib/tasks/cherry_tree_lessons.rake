task :cherry_tree_lessons => :environment do
	
	lc1 = LessonCategory.find_by_name 'Academics'
	lc2 = LessonCategory.find_by_name 'Behavior'
	lc3 = LessonCategory.find_by_name 'Social'
	lc4 = LessonCategory.find_by_name 'Health'

#Roman Numeral Lesson
l = Lesson.create :name => 'Roman Numerals', :description => 'Learn all about Roman Numerals', :lesson_category => lc1
s1 = l.screens.create :sequence => 1, :content => "<h1>Roman Numerals</h1><p>Roman numerals are letters of the alphabet that represent numbers.</p><ul><li>I = 1</li><li>V = 5</li><li>X = 10</li><li>L = 50</li><li>C = 100</li><li>D = 500</li><li>M = 1000</li></ul><img src='/images/rn1.png' alt='The Roman Coliseum.'/>"  
s2 = l.screens.create :sequence => 2, :content => "<h1>The History of Roman Numerals</h1><p>The Roman numerals system dates back over 2,000 years to ancient Rome. Today we usually use Arabic numbers, but you can still see Roman numerals in tables of contents, on some clocks and watches, or as a suffix on a persons name.</p><p>John Smith <em>III</em></p><img src='/images/rn2.png' alt='An old fashioned clock face.'/>"  
s3 = l.screens.create :sequence => 3, :content => "<h1>Roman Numerals Rule I</h1><p>I. Repeating a letter repeats its value. A letter can only be repeated up to three times in a row.   
</p><p>For example:</p><ul><li>III = 3</li><li>XX = 20</li><li>CCC = 300</li></ul>"
s4 = l.screens.create :sequence => 4, :content => "<h1>Roman Numerals Rule II</h1><p>II. When a letter of lesser value follows one of greater value, add them together.   
</p><p>For example:</p><ul><li>XI = 10 + 1 = 11</li><li>LVI = 50 + 5 + 1 = 56</li><li>DCCL = 500 + 100 + 100 + 50 = 750 </li></ul>"
s5 = l.screens.create :sequence => 5, :content => "<h1>Roman Numerals Rule III</h1><p>III. When a letter of lesser value comes before a letter of greater value, subtract the lesser value from the greater value.  Only use I, X or C in this way.   
</p><p>For example:</p><ul><li>IX = 10 - 1 = 9</li><li>XIX = 10 + (10 - 1) = 10 + 9 = 19</li><li>XCV = 100 - 10 + 5 = 95</li></ul>"

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
s3 = l.screens.create :sequence => 3, :content => "<h1>Claude Monet</h1><p>Claude Monet is one of the most famous Impressionists. Monet loved to paint 'en plein air' meaning outside 'in the open air.' Impressionism got its name from Monet’s painting called <em>Impression, Sunrise</em>.</p><img src='/images/imp3.png' alt='<em>Impression, Sunrise</em> by Claude Monet.'/>"
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
quest6 = q.questions.create :content => 'Which painting was most likely painted “en plein air”?'
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
quest7.answers.create :content => 'Assume they didn’t realize you were in line, and gently explain to them that you were waiting before them.', :correct => true
quest7.answers.create :content => "Tell them you don't appreciate their behavior and that they need to return to their proper place."
quest7.answers.create :content => "Say nothing."
quest7.answers.create :content => "Say nothing, but glare at them and <em>accidentally</em> push them a little."
quest8 = q.questions.create :content => '<img src="/images/comm8.png" alt="Cartoon yelling..."/><p>If you get into an argument, you should:</p>'
quest8.answers.create :content => 'Push the other person until they agree with you'
quest8.answers.create :content => "Try to understand the other person’s point of view and try to find a way to get you both what you want.", :correct => true
quest8.answers.create :content => "Just end the argument quickly, even if it means telling the other person they are right."
quest8.answers.create :content => "Be as loud as possible and make sure the other person agrees with you."
quest9 = q.questions.create :content => '<img src="/images/comm9.png" alt="teasing"/><p>If someone is making fun of you, you should:</p>'
quest9.answers.create :content => "Tell them you don’t appreciate the jokes and ask them to stop, and if the jokes don't stop, you should tell a teacher.", :correct => true
quest9.answers.create :content => "Make fun of them back."
quest9.answers.create :content => "Tell the teacher right away and demand they be punished."
quest9.answers.create :content => "Say nothing. You don't want to make things worse."
quest10 = q.questions.create :content => '<img src="/images/comm10.png" alt="Running late"/><p>Your mom is making you late to practice. You should:</p>'
quest10.answers.create :content => "Say nothing…she might not give you a treat after dinner."
quest10.answers.create :content => "Ask her if you can help her with something so that you can get to practice on time.", :correct => true
quest10.answers.create :content => "Yell at her for being late all the time."
quest10.answers.create :content => "Tell her that you really don't appreciate being late, and that you think her behavior is very rude."

#Emotions Lesson
l = Lesson.create :name => 'Emotions', :description => "Learn how to recognize emotions in other people's faces.", :lesson_category => lc3
s1 = l.screens.create :sequence => 1, :content => "<p>They say that it takes 43 muscles to frown and only 17 muscles to smile. Someone’s facial expressions can tell us a lot about how they are feeling. This quiz will teach you to recognize certain emotions from a person’s facial expressions.</p>"  

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
quest.answers.create :content => "Don’t say much, just eat and run"
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
quest4 = q.questions.create :content => '<img src="/images/fr4.png" alt="Show and tell"/><p>You tell your friend that you are going to bring a Barbie doll to show & tell. Next thing you know she brings the same Barbie doll to show & tell. What should you do?<p>'
quest4.answers.create :content => "Yell at her for copying you and tell her to find a new friend."
quest4.answers.create :content => "Tell your friend you are disappointed, but let her go first."
quest4.answers.create :content => "Tell your friend you are disappointed, and ask to go first.", :correct => true
quest4.answers.create :content => "Tell the teacher that she copied you and shouldn’t get to present to the class."
quest5 = q.questions.create :content => '<img src="/images/fr5.png" alt="Hurt my arm"/><p>You hurt your arm, and your friend didn’t ask you if you were ok. The next day she hurts her arm. What should you do?<p>'
quest5.answers.create :content => "Don’t ask if she is ok."
quest5.answers.create :content => "Laugh at her."
quest5.answers.create :content => "Tell her you’re glad she hurt her arm."
quest5.answers.create :content => "Ask her if he is ok and see if she needs help.", :correct => true
quest6 = q.questions.create :content => '<img src="/images/fr6.png" alt="Basketball hoop"/><p>You and PJ made plans to play at the park. Then Brian calls and invites you to come over and play basketball. You love basketball. What should you do?<p>'
quest6.answers.create :content => "Cancel your plans with PJ and go play basketball with Brian"
quest6.answers.create :content => "Don’t tell PJ anything, and go play basketball with Brian"
quest6.answers.create :content => "Thank Brian, but tell him that you already have plans to play with PJ", :correct => true
quest6.answers.create :content => "Tell Brian that you don’t like basketball."
quest7 = q.questions.create :content => '<img src="/images/fr7.png" alt="Juggling Clown"/><p>You are having a birthday party and you want to have a clown there. Your friend Sara is scared of clowns. What should you do?<p>'
quest7.answers.create :content => "Don’t invite Sara"
quest7.answers.create :content => "Invite Sara and don’t tell her about the clown and hope she’ll be ok"
quest7.answers.create :content => "Invite Sara, but tell her about the clown and help her not be afraid.", :correct => true
quest7.answers.create :content => "Make fun of Sara because she is afraid of clowns."
quest8 = q.questions.create :content => '<img src="/images/fr8.png" alt="Playing with toy truck"/><p>Your friend borrows your toy. When he brings it back, he doesn’t tell you that one of the wheels is broken. What should you do?<p>'
quest8.answers.create :content => "Scream at him for breaking the wheel."
quest8.answers.create :content => "Ask him calmly what happened, maybe there is a good explanation.", :correct => true
quest8.answers.create :content => "Don’t say anything, but borrow one of his toys and break it."
quest8.answers.create :content => "Tell everyone to not let him borrow toys."
quest9 = q.questions.create :content => '<img src="/images/fr9.png" alt="Babies"/><p>You see your friend crying. What should you do?<p>'
quest9.answers.create :content => "Nothing. It’s embarrassing to cry in front of people."
quest9.answers.create :content => "Tell them it’s ok, and find out what’s wrong.", :correct => true
quest9.answers.create :content => "Find out what’s wrong and then decide if it’s worth spending time helping them."
quest9.answers.create :content => "Tell them to toughen up."
quest10 = q.questions.create :content => '<img src="/images/fr10.png" alt="Birthday!"/><p>It’s your best friend’s birthday and you forgot. What should you do?:<p>'
quest10.answers.create :content => "Act like you remembered but forgot her card or present at home."
quest10.answers.create :content => "Avoid her all day so she doesn’t know you forgot."
quest10.answers.create :content => "Tell her you don’t celebrate birthdays."
quest10.answers.create :content => "Tell her the truth, and promise to make it up to her.", :correct => true

end






















