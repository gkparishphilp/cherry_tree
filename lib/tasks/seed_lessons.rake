task :seed_lessons => :environment do
	l = Lesson.create :name => '1st Grade Math: Addition', :description => 'How to add numbers.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello, and welcome to the first lesson! Today we are going to learn about addition.' 
	s2 = l.screens.create :sequence => 2, :content => 'Hold up 3 fingers from your left hand. Now hold up 4 fingers from your right hand. Now count how many fingers you are holding up. Once you are finished counting, go on to the next page.'
	s3 = l.screens.create :sequence => 3, :content => "If you counted 7, you are correct! Now to put that in number form, simply write 3 + 4 = 7. You would say 'three plus four equals seven'. The answer for an addition problem is called a sum. It's that easy!"
	s4 = l.screens.create :sequence => 4, :content => "Adding big numbers is easy as well. For example, think of a big number, say, 9. Now let's think of another big number such as 7. All you have to do is count the next 7 numbers after 9 to find out what 9 + 7 is. Give it a try and then move on to the next page." 
	s5 = l.screens.create :sequence => 5, :content => 'If you counted 16, you are correct! The more you practice adding numbers, the less you will have to use your fingers to count! There are many shortcuts to adding bigger number which you will learn as you get older.'

	q = l.quizzes.create :name => 'Addition Quiz', :point_value => 50
	quest = q.questions.create :content => '2+4=?'
	quest.answers.create :content => '4'
	quest.answers.create :content => '5'
	quest.answers.create :content => '6', :correct => true
	quest2 = q.questions.create :content => 'Find the sum of 4 and 6.'
	quest2.answers.create :content => '8'
	quest2.answers.create :content => '10', :correct => true
	quest2.answers.create :content => '13'
	quest3 = q.questions.create :content => '9+5=?'
	quest3.answers.create :content => '12'
	quest3.answers.create :content => '14'
	quest3.answers.create :content => '15', :correct => true
	quest4 = q.questions.create :content => '10+4=?'
	quest4.answers.create :content => '14', :correct => true
	quest4.answers.create :content => '16'
	quest4.answers.create :content => '17'

	l2 = Lesson.create :name => '1st Grade Math: Subtraction', :description => 'How to subtract numbers.'
	l2.screens.create :sequence => 1, :content  => 'Hello, and welcome to the second lesson. Today we will be learning about subtraction.'
	l2.screens.create :sequence => 2, :content => 'Try holding up four fingers. Go ahead and count to make sure that you are holding up 4 fingers and then go on to the next page.'
	l2.screens.create :sequence => 3, :content => 'Now we are going to subtract 3 fingers from your original 4 fingers. So go ahead and put down three of the four fingers you were holding up.'
	l2.screens.create :sequence => 4, :content => "If you have one finger left, then you are correct! To write that in number form, you would write 4 - 3 = 1. You would say 'four minus three equals one' The answer for a subtraction problem is called the difference."
	l2.screens.create :sequence => 5, :content => "Now let's try subtracting larger numbers. Let's try taking the number 14 and then subtracting 5 from it. All you have to do now is count the next 5 numbers below 14." 
	l2.screens.create :sequence => 6, :content => "If you counted 9, you are correct! So you would start at 14 and then count 13, 12, 11, 10, and then 9. 13 - 5 = 9."
	l2.screens.create :sequence => 7, :content => "Remember, the more you practice subtracting numbers, the faster you will be at it!"

	q2 = l2.quizzes.create :name => 'Subtraction Quiz', :point_value => 50
	quest = q2.questions.create :content => '3-1=?'
	quest.answers.create :content => '1'
	quest.answers.create :content => '2', :correct => true
	quest.answers.create :content => '4'
	quest2 = q2.questions.create :content => '7-3=?'
	quest2.answers.create :content => '2'
	quest2.answers.create :content => '3'
	quest2.answers.create :content => '4', :correct => true
	quest3 = q2.questions.create :content => '5-5=?'
	quest3.answers.create :content => '0', :correct => true
	quest3.answers.create :content => '3'
	quest3.answers.create :content => '5'
	quest4 = q2.questions.create :content => 'Find the difference of 11 and 4.'
	quest4.answers.create :content => '5'
	quest4.answers.create :content => '7', :correct => true
	quest4.answers.create :content=> '10'
	quest5 = q2.questions.create :content => 'Find the sum of 17 and 3.'
	quest5.answers.create :content => '14'
	quest5.answers.create :content => '17'
	quest5.answers.create :content => '20', :correct => true

	l = Lesson.create :name => '1st Grade Science: The Five Human Senses Part 1', :description => 'Sight and Hearing.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson! Today we will be learning about the first two human senses!'
	s2 = l.screens.create :sequence => 2, :content => 'The first sense we will be learning about is sight. Sight helps us see each other, see colors, and see people moving. We use our eyes to see things.'
	s3 = l.screens.create :sequence => 3, :content => "Sight is very important and can get worse if you don't take care of your eyes. You might have to wear glasses if your eyes get bad."
	s4 = l.screens.create :sequence => 4, :content => 'Hearing allows us to hear sounds. We use our ears to hear people, animals, and objects. These sounds can help us to identify things.'
	q = l.quizzes.create :name => 'Sight and Hearing Quiz', :point_value => 40
	quest = q.questions.create :content => 'Sight allows us to see things.'
	quest.answers.create :content => 'True', :correct => true
	quest.answers.create :content => 'False'
	quest2 = q.questions.create :content => "If you don't take good care of your eyes, you will eventually have to wear glasses."
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q.questions.create :content => 'We use our eyes to hear people, animals, and objects.'
	quest3.answers.create :content => 'True'
	quest3.answers.create :content => 'False', :correct => true
	quest4 = q.questions.create :content => 'Sounds can help us identify objects, such as an alarm clock ringing or people clapping hands.'
	quest4.answers.create :content => 'True', :correct => true
	quest4.answers.create :content => 'False'

	l2 = Lesson.create :name => '1st Grade Science: The Five Human Senses Part 2', :description => 'Touch, Smell, and Taste.'
	s1 = l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson! Today we will be learning about the last three human senses.'
	s2 = l2.screens.create :sequence => 2, :content => 'The sense of touch allows us to learn about the world by feeling it. We mostly use our hands but we can use any part of our body to feel things.'
	s3 = l2.screens.create :sequence => 3, :content => 'The sense of smell allows us to identify or enjoy things by their scent. We use our nose to smell things. Smells can also warn us about dangerous things.'
	s4 = l2.screens.create :sequence => 4, :content => 'Taste helps us to select and enjoy food and drinks! We have many different sensors in our tongue that help us taste salty, sweet, bitter, and sour things.'
	q2 = l2.quizzes.create :name => 'Touch, Smell, and Taste Quiz', :point_value => 50
	quest = q2.questions.create :content => 'We can only use our hands to touch and feel things.'
	quest.answers.create :content => 'True'
	quest.answers.create :content => 'False', :correct => true
	quest2 = q2.questions.create :content => 'Which sense would you use when your hear a alarm?'
	quest2.answers.create :content => 'Sight'
	quest2.answers.create :content => 'Hearing', :correct => true
	quest2.answers.create :content => 'Touch'
	quest3 = q2.questions.create :content => 'Which sense or senses allow you to enjoy food and drinks?'
	quest4 = q2.questions.create :content => 'We use our tongue to taste ice cream.'
	quest4.answers.create :content => 'True', :correct => true
	quest4.answers.create :content => 'False'
	quest5 = q2.questions.create :content => 'If there is a fire near your house, what is the first sense that you would usually use?'
	quest5.answers.create :content => 'Touch'
	quest5.answers.create :content => 'Smell', :correct => true
	quest5.answers.create :content => 'Taste'

	l = Lesson.create :name => '1st Grade History: The United States of America'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be learning about the United States of America and some of the facts about our country!'
	s2 = l.screens.create :sequence => 2, :content => 'The country we live in called the United States of America. This country was founded in 1776. There are 50 states in America and over 300 million people. The official language in the country is English.'
	s3 = l.screens.create :sequence => 3, :content => "The capital of our country is Washington D.C.. That's where the president and his family lives!"
	q = l.quizzes.create :name => 'U.S. History Quiz', :point_value => 30
	quest = q.questions.create :content => 'When was America founded?'
	quest.answers.create :content => '1776', :correct => true
	quest.answers.create :content => '1814'
	quest.answers.create :content => '2000'
	quest2 = q.questions.create :content => 'There are 50 states in America'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q.questions.create :content => 'Name three states in the United States of America.'
	
	l = Lesson.create :name => '2nd Grade Math: Fractions', :description => 'Introduction to Fractions'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson! Today we will be learning about fractions.'
	s2 = l.screens.create :sequence => 2, :content => 'A fraction means a part of a whole. A fraction can look like this 3/4 where the top number is called the numerator and the bottom number is called the denominator. The denominator tells us how many parts the whole is split into and the numerator tells us how many parts you have.'
	s3 = l.screens.create :sequence => 3, :content => "Let's pretend we have an apple pie and we split it into 4 equal slices. We give 3 slices to Bob and 1 slice to Billy. We would write that Bob has 3/4 (3 fourths) of the pie while Billy only has 1/4 (one quarter) of the pie."
	s4 = l.screens.create :sequence => 4, :content => "So not let's pretend we're cutting a big watermelon into 20 slices and everybody gets 2 slices. We would say everybody gets 2/20 of the watermelon."
	s5 = l.screens.create :sequence => 5, :content => "There are different ways to say different fractions. For example 1/2 can be called 'one-half', 'half', or even just 'one out of two'. For larger and more complex fractions like 7/8, we could say 'seven-eighths or seven out of eight'."
	q = l.quizzes.create :name => 'Fractions Quiz', :point_value => 50
	quest = q.questions.create :content => 'How would you say 1/4?'
	quest.answers.create :content => 'one-half'
	quest.answers.create :content => 'one-fourths', :correct => true
	quest.answers.create :content => 'two-thirds'
	quest2 = q.questions.create :content => 'John just split his cake into three equal slices and gives Jill one slice. How would you write the amount of pie Jill received in number form?'
	quest3 = q.questions.create :content => "Is saying 'two-thirds' the same as saying 'one out of three'?"
	quest3.answers.create :content => 'Yes'
	quest3.answers.create :content => 'No', :correct => true
	quest4 = q.questions.create :content => "Is saying 'four-fifths' the same as saying 'four out of five'?"
	quest4.answers.create :content => 'Yes', :correct => true
	quest4.answers.create :content => 'No'
	quest5 = q.questions.create :content => "How would you write 'nine out of eleven'?"

	l2 = Lesson.create :name => '2nd Grade Math: Adding and Subtracting Fractions', :description => 'How to add and subtract fractions'
	l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson. Today you will be using what you learned from lesson 1 and applying it to addition and subtraction.'
	l2.screens.create :sequence => 2, :content => 'To add two fractions together, simply take the numerator from the first fraction and add it with the numerator of the second fraction. It is important to know that the denominator must be the same number for the addition to work. The denominator stays the same.'
	l2.screens.create :sequence =>3, :content => "Once again John splits a pie into 5 equal pieces and gives you 2 slices. All of a sudden, John decides to give you an extra slice, so now you have 3 slices. Let's put that in number form."
	l2.screens.create :sequence => 4, :content => 'Take the equation 2/5 + 1/5. By adding the numerators 2 and 1 together, we get 3. The denominator stays the same, so our final answer is 3/5, or three-fifths.'
	l2.screens.create :sequence => 5, :content => 'Notice how if you try adding numbers with different denominators, for example 1/2 + 1/3, you cannot say it equals to 2/2, or 2/3, or 2/5. To add fractions with different denominators, we will have to use a different method which we will learn later.'
	l2.screens.create :sequence => 6, :content => 'With subtraction, we do the exact same thing as before. So taking the numerator of a fraction, we subtract it with the numerator from another fraction. For example, 4/6 - 3/6 = 1/6.'
	q = l2.quizzes.create :name => 'Fraction Addition and Subtraction Quiz', :point_value => 50
	quest = q2.questions.create :content => '3/5+1/5=?'
	quest.answers.create :content => '3/5'
	quest.answers.create :content => '1/5'
	quest.answers.create :content => '4/5', :correct => true
	quest2 = q2.questions.create :content => '1/2+0=?'
	quest2.answers.create :content => '1/2', :correct => true
	quest2.answers.create :content => '0'
	quest2.answers.create :content => '10/2'
	quest3 = q2.questions.create :content => '5/7-4/7=?'
	quest3.answers.create :content => '1/7', :correct => true
	quest3.answers.create :content => '5/0'
	quest3.answers.create :content => '5/7'
	quest4 = q2.questions.create :content => 'Write an addition equation that equals 4/5.'
	quest5 = q2.questions.create :content => 'Gabriel buys a pepperoni pizza and splits it into 12 slices. He takes 3 slices for himself. Hungry John takes 4 slices. Jennifer takes 2 slices. How much of the pizza is left over?'
	quest5.answers.create :content => '2/12'
	quest5.answers.create :content => 'No pizza is left'
	quest5.answers.create :content => '3/12', :correct => true
	
	l = Lesson.create :name=> '2nd Grade Science: Types of Animals', :description => 'Mammals, Birds, and Fishes.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson! Today we will be learning about the first three types of animals in the animal kingdom!'
	s2 = l.screens.create :sequence => 2, :content => 'The first type of animals are mammals. These animals include dogs, horses, even whales! All mammals have hair and must drink milk when they are a baby. Did you know that even humans are mammals?'
	s3 = l.screens.create :sequence => 3, :content => 'The second type of animals are birds. All birds have feathers and are born in hard-shelled eggs. The feathers along with its very light weight allow birds to fly, steer, and land.'
	s3 = l.screens.create :sequence => 4, :content => 'The third type of animals are fishes. Fishes are vertebrates (ver-tuh-brates) which mean that they have a backbone. Fishes live in water and have gills, scales, and fins. The gills are what fishes use to breathe underwater.'
	q = l.quizzes.create :name => 'Mammals, Birds, and Fishes Quiz', :point_value => 30
	quest = q.questions.create :content => 'Name at least three different types of mammals.'
	quest2 = q.questions.create :content => 'What do fishes use to breathe underwater?'
	quest2.answers.create :content => 'Nose'
	quest2.answers.create :content => 'Gills', :correct => true
	quest2.answers.create :content => 'Fins'
	quest3 = q.questions.create :content => 'What do birds have that allow them to fly, steer, and land?'
	quest3.answers.create :content => 'Beaks'
	quest3.answers.create :content => 'Fins'
	quest3.answers.create :content => 'Feathers', :correct => true

	l2 = Lesson.create :name => '2nd Grade Science: Types of Animals', :description => 'Reptiles, Amphibians, and Invertebrates.'
	s1 = l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson! Today we will be learning about the last three types of animals in the animal kingdom!'
	s2 = l.screens.create :sequence => 2, :content => 'The first type of animals are reptiles. Reptiles have scaly skins and are cold-blooded. A lot of reptiles can swim or walk on land. Reptiles include alligators, snakes, and lizards.'
	s3 = l2.screens.create :sequence => 3, :content => 'The second type of animals are amphibians (am-fi-bee-uns). Amphibians are born in water and are born with gills. But as they grow older, they grow lungs and can live on land. Amphibians include frogs, salamanders, and toads.'
	s4 = l2.screens.create :sequence => 3, :content => "The last type of animals are invertebrates. You remember that vertebrates are animals with backbones. Invertebrates are basically animals without backbones. Over 95% of all animals are invertebrates. A lot of bugs such as fruit flies and spiders are called invertebrates."
	q2 = l2.quizzes.create :name => 'Reptiles, Amphibians, and Invertebrates Quiz', :point_value => 30
	quest = q2.questions.create :content => 'Reptiles are warm-blooded.'
	quest.answers.create :content => 'True'
	quest.answers.create :content => 'False', :correct => true
	quest2 = q2.questions.create :content => 'Many bugs and insects are good examples of invertebrates because they do not have backbones.'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q2.questions.create :content => 'A lot of amphibians start off with lungs but soon grow gills and live underwater.'
	quest3.answers.create :content => 'True'
	quest3.answers.create :content => 'False', :correct => true

	l = Lesson.create :name => '2nd Grade History: Jobs', :description => 'Learn about different types of jobs.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be learning about different types of jobs in the world.'
	s2 = l.screens.create :sequence => 2, :content => 'In order to earn money, people have to work. People work by taking on jobs and careers.'
	s3 = l.screens.create :sequence => 3, :content => 'There are all sorts of jobs available for different types of people. If you really like plants, you can be a botanist and study plants for a living! If you like to save lives and fight fires you can be a firefighter.'
	s4 = l.screens.create :sequence => 4, :content => "In order to do a lot of these jobs, people need to go to school and get a degree. Some jobs require more school than others. For example, doctors will have to go to many more years of school than a police officer because there's so many things doctors need to know!"
	s5 = l.screens.create :sequence => 5, :content => "It's never too early to start thinking about what you want to do. If you're interested in a particular job, go ahead and ask you mom and dad or teacher about it!"
	q = l.quizzes.create :name => 'Jobs Quiz', :point_value => 30
	quest = q.questions.create :content => 'If you really like working with kids, which one of these jobs would you be?'
	quest.answers.create :content => 'Teacher', :correct => true
	quest.answers.create :content => 'Police Officer'
	quest.answers.create :content => 'Pilot'
	quest2 = q.questions.create :content => 'It is important to get a good education no matter what kind of job you do in the future.'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q.questions.create :content => 'Name at least careers of jobs you would like to do in the future.'
	
	l = Lesson.create :name => '3rd Grade Math: Multiplication', :description => 'How to multiply numbers.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be learning about multiplication.'
	s2 = l.screens.create :sequence => 2, :content => "Multiplication is basically repeated addition. It's kind of like adding the same number over and over again. To multiply the numbers 2 and 3, we would write 2x3. Think of that equation as the same thing as 2+2+2 or 3+3. So 2x3 is pretty much saying that you need to add three twos or two threes. Try solving 4x2 and then move to the next page."
	s3 = l.screens.create :sequence => 3, :content => "If you calculated 8, you are correct! Multiplication can be written in any order as well. 3x2 is the same thing as 2x3 and 5x4 is the same thing as 4x5. For 3x2, we would say 'three times two' and 4x5 is the same as saying 'four times five'.' The answer for a multiplication problem is called the product." 
	s4 = l.screens.create :sequence => 4, :content => 'There are a couple of cool tricks you can do with multiplication. Some of the cool tricks to remember are multiplication equations that have the number 0, 1, or 10.'
	s5 = l.screens.create :sequence => 5, :content => 'Any number multiplied by 0 is 0. 5 x 0 is the same thing as saying you have no fives, which is zero. Any number multiplied by 1 is just the same number. 5x1=5, 8x1=8, 215x1=215. To multiply a number by 10, just add an extra 0 digit on the right side. Try to find out what 7x10 is without having to do any addition.'
	s6 = l.screens.create :sequence => 6, :content => 'If you calculated 70, you are correct! Multiplication will be hard in the beginning and there are different methods to learn and practice. One way is to simply rewrite the problem as an addition equation. You can rewrite 4x3 as 4+4+4 or 3+3+3+3. Another way is to memorize the multiplication table and then keep on practicing and practicing.'
	q = l.quizzes.create :name => 'Multiplication Quiz', :point_value => 50
	quest = q.questions.create :content => '3x2=?'
	quest.answers.create :content => '6', :correct => true
	quest.answers.create :content => '5'
	quest.answers.create :content => '7'
	quest2 = q.questions.create :content => 'Find the product of 5 and 3.'
	quest2.answers.create :content => '8'
	quest2.answers.create :content => '10'
	quest2.answers.create :content => '15', :correct => true
	quest3 = q.questions.create :content => '28x1=?'
	quest3.answers.create :content => '28', :correct => true
	quest3.answers.create :content => '42'
	quest3.answers.create :content => '56'
	quest4 = q.questions.create :content => 'Is 8x2 the same thing as 2+8?'
	quest4.answers.create :content => 'Yes'
	quest4.answers.create :content => 'No', :correct => true
	quest5 = q.questions.create :content => 'What is 10 times 10?'
	quest5.answers.create :content => '5'
	quest5.answers.create :content => '20'
	quest5.answers.create :content => '100', :correct => true

	l2 = Lesson.create :name => '3rd Grade Math: Division', :description => 'How to divide numbers.'
	s1 = l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson. Today we will be learning about division.'
	s2 = l2.screens.create :sequence => 2, :content => 'Division is the process of dividing something into smaller parts. If I had 10 cupcakes and I divide it amongst 5 people, that means every everybody gets 2 cupcakes. In number form, division is written like 10 / 5 = 2. The solution of a division problem is called the quotient. Try solving 6/3.'
	s3 = l2.screens.create :sequence => 3, :content => 'If you answered 2, you are correct! Also note that division problems can be rewritten as a multiplication problem is written in the reversed order. For example, take 8/4=2. If we take the 2 and multiplied it by the 4, we get 2x4=8. However, division problems themselves cannot be written in reverse order! 4/2 is not the same as 2/4!'
	s4 = l2.screens.create :sequence => 4, :content => 'Similar to multiplication, there are also a couple of cool tricks for division as well! Any number divided by 1 is just he number itself while any number divided by the same number is 1. 7/1=7 is just saying that if you divide 7 into one piece, you still have 7. 7/7=1 is saying that if you divide 7 into 7 equal pieces, you get 1.'
	s5 = l2.screens.create :sequence => 5, :content => "Note however, that you cannot divide numbers by 0. if you tried to divide a number by 0 on a calculator, it will say 'error' or 'undefined'!"
	q2 = l2.quizzes.create :name => 'Division Quiz', :point_value => 50
	quest = q2.questions.create :content => '9/3=?'
	quest.answers.create :content => '2'
	quest.answers.create :content => '3', :correct => true
	quest.answers.create :content => '5'
	quest2 = q2.questions.create :content => "What is 12 divided by 4? (Hint, draw 12 sticks and then separate the sticks into group of 4. How many groups do you have?"
	quest2.answers.create :content => '8'
	quest2.answers.create :content => '48'
	quest2.answers.create :content => '3', :correct => true
	quest3 = q2.questions.create :content => "Find the quotient of 4 and 4."
	quest3.answers.create :content => '2', :correct => true
	quest3.answers.create :content => '4'
	quest3.answers.create :content => '8'
	quest4 = q2.questions.create :content => 'Is 16/2 the same as 2/16?'
	quest4.answers.create :content => 'Yes', :correct => true
	quest4.answers.create :content => 'No'
	quest5 = q2.questions.create :content => 'Is it possible to divide a number by 0?'
	quest5.answers.create :content => 'Yes'
	quest5.answers.create :content => 'No', :correct => true

	l = Lesson.create :name => '3rd Grade Science: The Water Cycle Part 1', :description => 'Evaporation and Condensation.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson! Today we will be learning about the first two stages of the water cycle: evaporation and condensation.'
	s2 = l.screens.create :sequence => 2, :content => "First, let's first talk about what the water cycle is. The earth only has limited amounts of water. That water keeps going around and around in a cycle called 'The Water Cycle'. This cycle has four stages and today we will be learning about he first two."
	s3 = l.screens.create :sequence => 3, :content => 'The first step of the water cycle is evaporation. Evaporation is when the sun heats up water in lakes, oceans, and rivers and turns that water into steam or wapor. The steam or vapor leaves the big pool of water and goes into the air.'
	s4 = l.screens.create :sequence => 4, :content => 'The next step of the water cycle is condensation. When the water vapor in the air gets cold, it turns back into liquid. The liquid in the sky eventually start forming cloud. When you pour a glass of cold water in a hot day and leave it outside, you will see water outside the glass, even though there is no leak in the glass! This is called condensation.'
	q = l.quizzes.create :name => 'Evaporation and Condensation Quiz', :point_value => 40
	quest = q.questions.create :content => 'Evaporation takes place only when the water is exposed to heat or sunlight.'
	quest.answers.create :content => 'True', :correct => true
	quest.answers.create :content => 'False'
	quest2 = q.questions.create :content => 'When water is evaporated, where does it go?'
	quest2.answers.create :content => 'To another body of water'
	quest2.answers.create :content => 'To the sky', :correct => true
	quest2.answers.create :content => 'To the plants'
	quest3 = q.questions.create :content => 'Water vapor turns back into liquid when the temperature gets hotter.'
	quest3.answers.create :content => 'True'
	quest3.answers.create :content => 'False', :correct => true
	quest4 = q.questions.create :content => 'What happens when you leave a class of cold water outside on a hot day? (Try it!)'

	l2 = Lesson.create :name => '3rd Grade Science: The Water Cycle Part 2', :description => 'Precipitation and Collection.'
	s1 = l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson! Today we will be learning about the last two stages of the water cycle: precipitation and collection.'
	s2 = l2.screens.create :sequence => 2, :content => 'Precipitation occurs after condensation. When so much water has condensed that the air cannot hold it anymore, it starts to rain. Water falls back to the earth either by rain, snow, sleet, or hail. This process is called precipitation.'
	s3 = l2.screens.create :sequence => 3, :content => "Collection occurs when the water that falls back to earth gets 'collected'. The water can end back up in another big body or water or it can be absorbed by plants. The water even soak into the earth and become part of 'ground water'."
	s4 = l2.screens.create :sequence => 4, :content => 'Of course, after all this, the process starts all over again!'
	q2 = l2.quizzes.create :name => 'Precipitation and Collection Quiz', :point_value => 40
	quest = q2.questions.create :content => 'The only way precipitation occurs is through rain.'
	quest.answers.create :content => 'True'
	quest.answers.create :content => 'False', :correct => true
	quest2 = q2.questions.create :content => 'Precipitation usually occurs when there are thick, dark clouds in the sky.'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q2.questions.create :content => 'Name three places that water can end up after precipitation.'
	quest4 = q2.questions.create :content => 'What happens after collection?'
	quest4.answers.create :content => 'Nothing'
	quest4.answers.create :content => 'Precipitation'
	quest4.answers.create :content => 'Evaporation', :correct => true

	l = Lesson.create :name => '3rd Grade History: Founding Fathers', :description => 'Learn about some of the people that helped build this country!'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson! Today we will be learning about some of the important people that establish the United States of America.'
	s2 = l.screens.create :sequence => 2, :content => 'George Washington. George Washington was a famous general in the American army back in the Revolutionary War in 1776. After leading the Continental Army to victory against the British, he was elected as the first president of the United States.'
	s3 = l.screens.create :sequence => 3, :content => 'Benjamin Franklin. Benjamin Franklin was a famous scientist, author, and politician who was famous for promoting independence from the British. Benjamin Franklin conducted many science experiements involving electricity. Benjamin Franklin never became a president.'
	s4 = l.screens.create :sequence => 4, :content => 'Alexander Hamilton. Alexander Hamilton was a politician and lawyer who was best known for drafting the Constitution of the United States of America, a document that established the rights of citizens and the government. Alexander Hamilton was killed in a duel against a rival politician.'
	q = l.quizzes.create :name => 'Founding Fathers Quiz', :point_value => 30
	quest = q.questions.create :content => 'Who was the first president of the United States of America?'
	quest2 = q.questions.create :content => 'Which founding father was known for his interest in science?'
	quest2.answers.create :content => 'George Washington'
	quest2.answers.create :content => 'Benjamin Franklin', :correct => true
	quest2.answers.create :content => 'Alexander Hamilton'
	quest3 = q.questions.create :content => 'What was the name of the document that Alexander Hamilton help draft?'

	
	l = Lesson.create :name => '4th Grade Math: Advanced Arithmetic', :description => 'Revision of Addition, Subtraction, Multiplication, and Division.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be going over harder and more complex arithmetic equations.'
	s2 = l.screens.create :sequence => 2, :content => "Unfortunately, we only have 10 fingers and a lot of times we have to add bigger numbers. Let's try to add 11 and 12 together. To do so, you would want to add the two right digits together and then add the two left digits together. If you did it correctly, you should get 23."
	s3 = l.screens.create :sequence => 3, :content => 'Now suppose that if you add the two numbers on the right, it becomes bigger than 10. Try to solve 18+13. To solve this problem, you would have to tackle problem from the right side first and then move to the left. 8+3 is 11, so we keep the 1 on the right digit and then carry over the 1 on the left digit to the left hand side of the problem. Try to do this and then hit next.'
	s4 = l.screens.create :sequence => 4, :content => 'If you got 31, you are correct! The same thing works with subtraction except this time you do the opposite. If you have an equation such as 24-8, what you have to do is count down eight times from 4. Then you would take 1 away from the number on the left side. If you ended up with 16, you are correct!'
	s5 = l.screens.create :sequence => 5, :content => 'Multiplication is when things get tricky. Suppose to want to multiply 12 and 6. What you would want to do first is multiply the two right side numbers, so multiply 6 and 2 to get 12. Write down the 2 on the right side of your answer but now you want to carry over the 1 into the left hand side. Now you have to multiply the 6 and the 1 and then you add on the 1 you carried over.'
	s6 = l.screens.create :sequence => 6, :content => 'If you answered 72, go ahead and give yourself a pat on the back because that was a tough equation. For division is when it gets much trickier. say you want to divide 36 by 2. You would write out 36/2. This time however, you need to solve the problem from left to right and then carry over the remainder to the right. We start with 3/2 which is 1 with a remainder of 1. Now we attach the remaining 6 to the right of that 1 and then we solve 16/2.'
	s7 = l.screens.create :sequence => 7, :content => 'If you answered 18, you are correct! Once again with these kind of harder arithmetic problems, the only way you will get better is if you keep on practicing.'

	q = l.quizzes.create :name => 'Advanced Arithmetic Quiz', :point_value => 50
	quest = q.questions.create :content => 'What is the difference between 25 and 6?'
	quest.answers.create :content => '13'
	quest.answers.create :content => '19', :correct => true
	quest.answers.create :content => '31'
	quest2 = q.questions.create :content => 'Find the quotient of 64 and 4.'
	quest2.answers.create :content => '16', :correct => true
	quest2.answers.create :content => '60'
	quest2.answers.create :content => '64'
	quest3 = q.questions.create :content => "For a history project, Mrs. Smith divides her class into four groups of four students, three groups of three students and one group of just two students. How many kids are in Mrs. Smith's class?"
	quest3.answers.create :content => '24'
	quest3.answers.create :content => '26', :correct => true
	quest3.answers.create :content => '30'
	quest4 = q.questions.create :content => 'Which order of equations will produce the smallest to largest answer from left to right?'
	quest4.answers.create :content => '3+3, 3-3, 3x3, 3/3'
	quest4.answers.create :content => '4/4, 4x4, 4-4, 4+4'
	quest4.answers.create :content => '5-5, 5/5, 5+5, 5x5', :correct => true
	quest5 = q.questions.create :content => 'Find 4 equations that will produce the solution 4 using only the numbers 1, 2, and 4.'

	l2 = Lesson.create :name => '4th Grade Math: Mixed and Improper Fractions', :description => 'Adding and subtracting different types of fractions.'
	s1 = l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson. Today we will be going over some of the more complex operations of fractions.'
	s2 = l2.screens.create :sequence => 2, :content => "We've worked with some of the more basic fractions in the past. Fractions such as 1/3, 3/4, 7/8 and so on. These were called proper fractions. Today we will be learning about improper fractions and mixed fractions."
	s3 = l2.screens.create :sequence => 3, :content => 'Improper Fractions are fractions where the numerator is bigger or equal to the denominator. Fractions such as 7/2 or 5/5 are examples of improper fractions. A fraction of 7/5 implies that you have a whole and two extra pieces.'
	s4 = l2.screens.create :sequence => 4, :content => 'Anytime the numerator is the same as the denominator, it is the same as 1, or a whole. 5/5, 8/8, 32/32 are all the same number. Try to divide the numerator by the denominator and you will always get 1.'
	s5 = l2.screens.create :sequence => 5, :content => "A Mixed Fraction is a whole number and a fraction combined into one 'mixed' number. 1 3/4  is the same as 7/4 although it is written differently. Try to change the mixed fraction 2 1/2 into an improper fraction."
	s6 = l2.screens.create :sequence => 6, :content => 'If you guessed 5/2, you are correct! The easy way to do this is to multiply the whole number and the denominator and then add the numerator.'
	s7 = l2.screens.create :sequence => 7, :content => 'To add fractions with different denominators, we must first find common multiples of the denominator by multiplication. Suppose you want to add 3/4 and 5/6. We must first find the common multiple of 4 and 6, which is 12. We would multiply the numerator and denominator of the first fraction by 3 and then multiply the numerator and denominator of the second fraction by 2. Try to finish the rest of this equation.'
	s8 = l2.screens.create :sequence => 8, :content => '3/4 becomes 9/12 and 5/6 becomes 10/12. Now we have a simple addition problem 9/12 + 10/12 = 19/12. This concept works exactly the same with subtraction.' 
	s9 = l2.screens.create :sequence => 9, :content => 'Fractions can be simplified. 3/6 is the same number as 1/2. All you have to do is see if there is a common factor between the numerator and denominator. In this case, 3 is a common factor between 3 and 6. Therefore you can divide the numerator and the denominator by the common factor 3 and you get 1/2.' 

	q2 = l2.quizzes.create :name => 'Mixed and Improper Fractions'
	quest = q2.questions.create :content => 'Write 3 1/4 as an improper fraction.'
	quest2 = q2.questions.create :content => '2 1/3 + 3 1/3=?'
	quest2.answers.create :content => '5 2/3', :correct => true
	quest2.answers.create :content => '2 2/3'
	quest2.answers.create :content => '5'
	quest3 = q2.questions.create :content => 'Which number is larger, 2 1/3 or 8/3?'
	quest3.answers.create :content => '2 1/3'
	quest3.answers.create :content => '8/3', :correct => true
	quest4 = q2.questions.create :content => '7/8 - 3/4=?'
	quest4.answers.create :content => '3/4'
	quest4.answers.create :content => '1/4'
	quest4.answers.create :content => '1/8', :correct => true
	quest5 = q2.questions.create :content => '1/2 + 3/6 - 1=?'
	quest5.answers.create :content => '0', :correct => true
	quest5.answers.create :content => '1/2'
	quest5.answers.create :content => '2/3'

	l = Lesson.create :name => '4th Grade Science: Parts of a Plant'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson! Today we will be learning about different parts of a plant.'
	s2 = l.screens.create :sequence => 2, :content => 'Root: The root is the lowest part of the plant usually inside the mud. The roots are like straws that help the plant absorb water and minerals from the soil. The roots also make sure the plant does not fall over and can store extra food for the plant.'
	s3 = l.screens.create :sequence => 3, :content => "Stem: The stem is like the plumbing system of the plant. A lot of the plant's nutrients and water travels from the root through the stem. Food stored in the form of glucose also travels through the stems from the leaves. Like the roots, the stem also supports the plant and prevents it from falling over."
	s4 = l.screens.create :sequence => 4, :content => "Leaves: A lot of the plant's food is made from the leaves. Leaves help capture sunlight in a process called photosynthesis, which we will learn in the next lesson."
	s5 = l.screens.create :sequence => 5, :content => 'Flower: The flower is in charge of a lot of the reproductive part of the plant. Flowers have pollen as well as tiny eggs called ovules which helps in the creation of a fruit.'
	q = l.quizzes.create :name => 'Plant Parts Quiz', :point_value => 50
	quest = q.questions.create :content => 'Name three things that the root of a plant does.'
	quest2 = q.questions.create :content => 'Both the stem and the roots help the support the plant.'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q.questions.create :content => 'Leaves help create food in a process called precipitation.'
	quest3.answers.create :content => 'True'
	quest3.answers.create :content => 'False', :correct => true
	quest4 = q.questions.create :content => 'Which part of the plant helps transports food and nutrients?'
	quest4.answers.create :content => 'Roots'
	quest4.answers.create :content => 'Flower'
	quest4.answers.create :content => 'Stem', :correct => true
	quest5 = q.questions.create :content => 'What does the flower do?'
	quest5.answers.create :content => 'Reproduction', :correct => true
	quest5.answers.create :content => 'Photosynthesis'
	quest5.answers.create :content => 'Ovules'

	l2 = Lesson.create :name => '4th Grade Science: Photosynthesis'
	l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson. Today we will be learning about photosynthesis.'
	l2.screens.create :sequence => 2, :content => 'What is photosynthesis: Photosynthesis is the process plants use to make their own food. Plant leaves have something called chlorophyll (clor-ro-fill) which helps absorbs sunlight.'
	l2.screens.create :sequence => 3, :content => 'Step 1: The sunlight is combined with water, carbon dioxide, and nutrients from the soil. Carbon dioxide is the gas that humans breathe out after inhaling oxygen.'
	l2.screens.create :sequence => 4, :content => 'Step 2: The chlorophyll processes the ingredients and create sugar (plant food) as well as oxygen (gas that humans breathe in in order to live).'
	l2.screens.create :sequence => 5, :content => 'We can see that plants and animals/humans need each other in order to survive since humans need oxygen to breathe and plants need carbon dioxide to make food.'
	q2 = l2.quizzes.create :name => 'Photosynthesis Quiz', :point_value => 40
	quest = q2.questions.create :content => 'Which part of the plant is the chlorophyll located in?'
	quest.answers.create :content => 'Stem'
	quest.answers.create :content => 'Flower'
	quest.answers.create :content => 'Leaves', :correct => true
	quest2 = q2.questions.create :content => 'What are the three ingredients plants need to create food?'
	quest3 = q2.questions.create :content => 'Humans need carbon dioxide in order to survive'
	quest3.answers.create :content => 'True'
	quest3.answers.create :content => 'False', :correct => true
	quest4 = q2.questions.create :content => 'It is important to take care of plants and the environment since animals and plants need each other in order to survive.'
	quest4.answers.create :content => 'True', :correct => true
	quest4.answers.create :content => 'False'

	l = Lesson.create :name => '4th Grade History: The Three Branches of Government', :description => 'Legislative, Executive, and Judicial.'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be learning about he three branches of government in the United States of America.'
	s2 = l.screens.create :sequence => 2, :content => 'Legislative Branch. Headed by Congress which includes both the House of Representatives and the Senate. The Legislative Branch is responsible for making laws. Some of these laws include spending bills, impeaching officials, and approving treaties.'
	s3 = l.screens.create :sequence => 3, :content => 'Executive Branch. Headed by the President. The President is responsible for carrying out federal laws and directing foreign policy. The powers of the President include heading the Armed Forces, dealing with other countries, and vetoing laws.'
	s4 = l.screens.create :sequence => 4, :content => "Judicial Branch. Headed by the Supreme Court. The Judicial Branch is responsible for interpreting the Constitution, reviewing laws, and deciding on cases that involve states' rights. Members of the Judicial Branch are hand picked by the President."
	s5 = l.screens.create :sequence => 5, :content => 'Each of these branches make sure the other branch does not have too much power in a system called checks and balances.'
	q = l.quizzes.create :name => '3 Branches of the Government Quiz', :point_value => 40
	quest = q.questions.create :content => 'Which branch is headed by the President of the United States?'
	quest.answers.create :content => 'All of them'
	quest.answers.create :content => 'The Executive Branch', :correct => true
	quest.answers.create :content => 'The Judicial Branch'
	quest2 = q.questions.create :content => 'What is the name of the two bodies within the Legislative Branch?'
	quest3 = q.questions.create :content => 'How are members of the Judicial Branch chosen?'
	quest3.answers.create :content => 'They are hand-picked by the Executive Branch', :correct => true
	quest3.answers.create :content => 'They are elected by the people'
	quest3.answers.create :content => 'They are chosen at birth to be a judge'
	quest4 = q.questions.create :content => 'The name of the system that makes sure that each branch has equal power is called checks and balances.'
	quest4.answers.create :content => 'True', :correct => true
	quest4.answers.create :content => 'False'

	
	l=Lesson.create :name => '5th Grade Math: Fraction Multiplication', :description => 'Learn how to multiply fractions.'
	s1 = l.screens.create :sequence => 1, :content => 'Welcome to the first lesson. Today we will be learning how to multiply and divide fractions.'
	s2 = l.screens.create :sequence => 2, :content => "Fraction multiplication is quite simple, even easier than fraction addition. All you have to do is multiply the numerators of the two fractions and the denominators of the two fractions. Let's take 5/7 and 1/2. To multiply these two fractions, we take 5x1=5 and 7x2=14. We then combine the answers and we get 5/14."

	q = l.quizzes.create :name => 'Fraction Multiplication Quiz', :point_value => 50
	quest = q.questions.create :content => '3/4 x 1/2=?'
	quest.answers.create :content => '2'
	quest.answers.create :content => '3/8', :correct => true
	quest.answers.create :content => '4/6'
	quest2 = q.questions.create :content => '6/8 x 1=?'
	quest2.answers.create :content => '0'
	quest2.answers.create :content => '1'
	quest2.answers.create :content => '3/4', :correct => true
	quest3 = q.questions.create :content => '(1/10) x (10/1) = ?'
	quest3.answers.create :content => '0'
	quest3.answers.create :content => '1', :correct => true
	quest3.answers.create :content => '10'
	quest4 = q.questions.create :content => '1 1/2 x 2 1/2=?'
	quest4.answers.create :content => '12'
	quest4.answers.create :content => '3 3/4', :correct => true
	quest4.answers.create :content => '3 1/2'
	quest5 = q.questions.create :content => 'Find the product of 3/7 and 5/2.'
	quest5.answers.create :content => '10/14'
	quest5.answers.create :content => '8/9'
	quest5.answers.create :content => '1 1/14'

	l2 = Lesson.create :name => '5th Grade Math: Fraction Division', :description => 'Learning how to divide fractions.'
	l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson. Today we will be learning how to divide fractions.'
	l2.screens.create :sequence => 2, :content => "Before we learn how to divide fractions, we need to first know what a reciprocal is. The reciprocal of a fraction is the fraction you would multiply the original fraction with to get 1. It's also basically just the numerator and the denominator switched around! Let's take the fraction 3/4. The reciprocal is simply 4/3. If you multiply those two fractions together, you get 12/12, or 1."
	l2.screens.create :sequence => 3, :content => "To divide a two fractions, all you simply have to do is to take the first fraction and multiply it with the reciprocal of the second fraction. Let's try 3/5 / 2/3. All you simply have to do is flip the second fraction to 3/2. Then you multiply 3/2 and with the first fraction 3/5. Go ahead and give it a try."
	l2.screens.create :sequence => 4, :content => 'If you got 9/10, you are correct! Once again, there are a couple of tricks when it comes to dividing fractions. As usual, dividing by 0 is impossible. For equations that tell you to divide by 10, simply add an extra 0 in the units side of the denominator.'
	q2 = l2.quizzes.create :name => 'Fraction Division Quiz', :point_value => 50
	quest = q2.questions.create :content => '3/8 / 1/2=?'
	quest.answers.create :content => '3/4', :correct => true
	quest.answers.create :content => '4'
	quest.answers.create :content => '1/2'
	quest2 = q2.questions.create :content => '7/5 / 3/4=?'
	quest2.answers.create :content => '10/9'
	quest2.answers.create :content => '2/5'
	quest2.answers.create :content => '28/15', :correct => true
	quest3 = q2.questions.create :content => 'Find the quotient of 10/8 and 5/4.'
	quest3.answers.create :content => '1', :correct => true
	quest3.answers.create :content => '7/5'
	quest3.answers.create :content => '1/2'
	quest4 = q2.questions.create :content => '14/15 / 0/3=?'
	quest4.answers.create :content => '0'
	quest4.answers.create :content => '0/3'
	quest4.answers.create :content => 'No answer', :correct => true
	quest5 = q2.questions.create :content => 'Jonathan has 3 out of 5 slices of an apple pie and now Caleb wants Jonathan to give him half of his share. How much out of the original pie do Caleb and Jonathan now get?'
	quest5.answers.create :content => 'One-fifth of the pie.'
	quest5.answers.create :content => 'Three-tenths of the pie.', :correct => true
	quest5.answers.create :content => 'One-sixth of the pie.'
	
	l = Lesson.create :name => '5th Grade Science: The Scientific Method Part 1', :description => 'Observation and Hypothesis?'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be learning about the scientific method.'
	s2 = l.screens.create :sequence => 2, :content => 'What is the scientific method? The scientific method is a way to ask and answer scientific questions by making observations and doing experiments. Today we will be covering the first two steps of the scientific method.'
	s3 = l.screens.create :sequence => 3, :content => "Step 1: Observation. This step is where you ask yourself a question based on something you observe. Ask questions that have 'how, where, why, who, what, which, and when' in them. Hopefully this is a question about something that you can measure."
	s4 = l.screens.create :sequence => 4, :content => "Step 2: Hypothesis. Once you have a question, it is important to come up with a hypothesis. The hypothesis is an educated guess about how things will work. The format of a hypothesis usually goes like this: 'IF______(I do this), then_______(this) will happen.' Your hypothesis does not have to be correct, it's just so you can make some kind of judgement before you start experimenting."

	q = l.quizzes.create :name => 'Scientific Theory: Observation and Hypothesis Quiz', :point_value => 40
	quest = q.questions.create :content => 'The first step of the scientific theory is to create a hypothesis.'
	quest.answers.create :content => 'True'
	quest.answers.create :content => 'False', :correct => true
	quest2 = q.questions.create :content => 'It is best to create an observation based on something that can be measured.'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q.questions.create :content => 'A hypothesis does not always have to be correct.'
	quest3.answers.create :content => 'True', :correct => true
	quest3.answers.create :content => 'False'
	quest4 = q.questions.create :content => 'Try to come up with your own hypothesis!'

	l2 = Lesson.create :name => '5th Grade Science: The Scientific Method Part 2', :description => 'Experiment and Analysis.'
	l2.screens.create :sequence => 1, :content => 'Hello and welcome to the second lesson. Today we will be learning about he last two step of the scientific method.'
	l2.screens.create :sequence => 2, :content => 'Step 3: Experiment. This is the fun part. This is where you will conduct experiments that will test and see whether your hypothesis is correct or not. Your experiments need to be a fair test meaning that you change only one factor at a time while you keep everything else the same.'
	l2.screens.create :sequence => 3, :content => 'It is also important to keep repeating experiments several times to ensure accuracy. Always make sure you record the results of every experiment.'
	l2.screens.create :sequence => 4, :content => 'Step 4: Analysis. Once you have finished experimenting, you need to take the data you recorded to make an analysis. You will use this information you obtained to determine whether your hypothesis is true or not. After determining whether your hypothesis is true or not, you need to communicate your results in a final report.'
	q2 = l2.quizzes.create :name => 'Scientific Method: Experiment and Analysis Quiz', :point_value => 40
	quest = q2.questions.create :content => 'It is not necessary to experiment in order to reach the last step of the scientific method.'
	quest.answers.create :content => 'True'
	quest.answers.create :content => 'False', :correct => true
	quest2 = q2.questions.create :content => 'You should conduct your experiments multiple times to ensure accuracy.'
	quest2.answers.create :content => 'True', :correct => true
	quest2.answers.create :content => 'False'
	quest3 = q2.questions.create :content => 'After you have obtained your data and determined wherther your hypothesis is true or false, what should you do?'
	quest4 = q2.questions.create :content => 'Take the hypothesis you came up with in Lesson #1 and see if you can create an experiment to test it. If you can, go ahead and do the experiment!'
	
	l = Lesson.create :name => '5th Grade History: The Bill of Rights'
	s1 = l.screens.create :sequence => 1, :content => 'Hello and welcome to the first lesson. Today we will be learning about the Bill of Rights.'
	s2 = l.screens.create :sequence => 2, :content => "The Bill of Rights is a document that lists some of the rights reserved to individuals and the state. The Bill of Rights was written by states who were afraid that the Federal Government would be too big and have too much power. The Bill of Rights would guarantee certain 'unalienable' rights to the people."
	s3 = l.screens.create :sequence => 3, :content => 'The Bill of Rights was approved in 1791 and in the beginning started off with 10 amendments. All of the amendments afterwards are important as well but are not called the Bill of Rights. The first three amendments include the freedom of speech, freedom of having guns, and freedom to not let soldiers into your house.'
	s4 = l.screens.create :sequence => 4, :content => 'Throughout the years, Congress added more amendments that included freedom from slavery, allowing the government to collect income tax, and so on. Amendments can be repealed but the process of deleting an amendment is very long and hard.'
	q = l.quizzes.create :name => 'The Bill of Rights Quiz', :point_value => 40
	quest = q.questions.create :content => 'How many amendments are in the Bill of Rights?'
	quest.answers.create :content => '5'
	quest.answers.create :content => '8'
	quest.answers.create :content => '10', :correct => true
	quest2 = q.questions.create :content => 'The Bill of Rights was approved at the beginning of the Revolutionary War.'
	quest2.answers.create :content => 'True'
	quest2.answers.create :content => 'False', :correct => true
	quest3 = q.questions.create :content => 'Is is possible to repeal an amendment?'
	quest3.answers.create :content => 'Yes', :correct => true
	quest3.answers.create :content => 'No'
	quest4 = q.questions.create :content => 'Name at least 3 amendments that were passed AFTER the Bill of Rights.'		
end
