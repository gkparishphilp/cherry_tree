class CherryTreeMigration < ActiveRecord::Migration

	def change
		
		add_column	:users, :type, :string
		
		
		create_table :awards, :force => true do |t|
			# awards are customizeable incentives.  They may be amazon products, custom coupons, promises, etc.
			t.references	:creator, :polymorphic => true # the creator is basically the parent who added the award
			t.references	:award_category
			t.string		:name
			t.text			:description
			t.string		:asin # for Amazon products
			t.integer		:point_cost  # TODO - I'm going to re-add this here for now... to be overridden by cost in assignemnt
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :award_assignments, :force => true do |t|
			t.references	:award
			t.references	:user  # the user that this award is available to
			t.references	:creator # who created the assignemnt
			t.text			:description # TODO - implement -- let parent add/over-ride award description and add details
			t.integer		:point_cost
			t.boolean		:recurring, :default => true # an award is eligible for multiple unlocks.  False for one-time awards
			t.string		:status
			t.timestamps
		end
		
		create_table :ownings, :force => true do |t|
			t.references	:user
			t.references	:ownable, :polymorphic => true
			t.timestamps
		end
		
		create_table :point_spendings, :force => true do |t|
			t.references	:user
			t.references	:owning
			t.integer		:points
			t.timestamps
		end
		
		add_index	:awards, :award_category_id
		add_index	:award_assignments, :status
		add_index	:award_assignments, ["user_id","status"], :name => 'fk_active_awards'
		
		
		create_table :checkins, :force => true do |t|
			t.references	:user
			t.string		:content
			t.references	:objective_assignment # not always necessary, e.g. for status
			t.integer		:confirmed_by, :default => 0 # this is a user_id 0, nothing, -1 ignored
			t.datetime		:confirmed_at
			t.boolean		:done
			t.timestamps
		end
		
		create_table :objectives, :force => true do |t|
			t.string		:name
			t.references	:objective_category
			t.references	:creator, :polymorphic => true
			t.text			:description
			t.integer		:point_value # default for app-objectives to be overridden by the assignment
			t.string		:objective_type # one-time, recurring, milestone, daily, etc. to auto pre-set assignment values?????
			t.timestamps
		end
		
		create_table :objective_assignments, :force => true do |t|
			t.references	:user
			t.references	:objective
			t.references	:creator
			t.references	:award_asignment # to support ability to tie goals to specific awards on successful completion
			t.text			:description # to customize detailed notes for an assignment
			t.integer		:priority # placeholder to prioritize and/or sort objctives
			t.integer		:times # number of required checkins....
			t.string		:period # ... per this unit time
			t.datetime		:due_at # for one-time activities -- i.e. goals
			t.boolean		:req_checkin, :default => true # true is self-reported by child. False is parent-reported
			t.boolean		:req_confirm, :default => false # child earns points automatically
			t.integer		:point_value, :default => 100
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :point_earnings, :force => true do |t|
			t.references	:user # the person who earned this
			t.references	:earned_for, :polymorphic => true # an objective_assignment, checkin, note, achievement, etc.
			t.integer		:points
			t.string		:earning_type # to use later? e.g. gift, achievement, etc???
			t.timestamps
		end
		
		add_index :objectives, :objective_category_id
		add_index :objective_assignments, :req_confirm
		add_index :objective_assignments, :status
		add_index :objective_assignments, ["user_id","status"], :name => :fk_active_assignments
		
		
		
		create_table :invitations, :force => true do |t|
			t.references	:creator
			t.references	:user 
			t.references	:child
			t.string		:code
			t.string		:role
			t.string		:nickname
			t.string		:message
			t.string		:status
			t.timestamps
		end
		
		add_index :invitations, :creator_id
		add_index :invitations, :user_id
		add_index :invitations, :child_id
		add_index :invitations, :code

		##### Lessons #######
		
		create_table :lessons do |t|
			t.string		:name
			t.references	:lesson_category
			t.text			:description
			t.string		:lesson_type
			t.timestamps
		end
		
		create_table :lesson_assignments do |t|
			t.references	:user
			t.references	:lesson
			t.references	:creator
			t.integer		:point_value, :default => 1
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :lesson_screens do |t|
			t.references	:lesson
			t.string		:title
			t.text			:content
			t.integer		:sequence
			t.timestamps
		end
		
		create_table :lesson_viewings do |t|
			t.references	:lesson
			t.references	:user
			t.references 	:lesson_screen, :default => 0
			t.timestamps
		end
		
		add_index :lesson_assignments, [ :lesson_id, :user_id, :creator_id ]
		add_index :lesson_screens, [ :lesson_id, :sequence ]
		add_index :lesson_viewings, [ :lesson_id, :user_id ]
		add_index :lesson_viewings, :lesson_screen_id
		
		####### Notes ############
		
		create_table :notes, :force => true do |t|
			t.references	:sender
			t.references	:font
			t.references	:background
			t.references	:border
			t.string		:font_color, :default => '#333'
			t.string		:subject
			t.text			:content
			t.timestamps
		end
		
		create_table :note_deliveries, :force => true do |t|
			t.references	:note
			t.references	:recipient
			t.boolean		:unread, :default => true
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		######### Quizzes #############
		
		create_table :quizzes, :force => true do |t|
			t.references	:lesson
			t.string		:name
			t.references	:creator
			t.text			:description
			t.integer		:point_value, :default => 0
			t.integer		:level
			t.string		:quiz_type # e.g. for surveys with no right or wrong answers
			t.timestamps
		end
		
		# canned answers for multiple-choice
		create_table :quiz_answers, :force => true do |t| 
			t.references	:quiz_question
			t.text			:content
			t.boolean		:correct # the right answer
			t.timestamps
		end
		
		create_table :quiz_answerings, :force => true do |t|
			t.references	:quizzing
			t.references	:quiz_question
			t.references	:quiz_answer
			t.text			:response # for free-response
			t.timestamps
		end
		
		create_table :quiz_assignments do |t|
			t.references	:user
			t.references	:quiz
			t.references	:creator
			t.integer		:point_value, :default => 1
			t.string		:status
			t.timestamps
		end
		
		create_table :quiz_questions, :force => true do |t|
			t.references	:quiz
			t.text			:content
			t.string		:extra_content # e.g. DYK
			t.integer		:point_value, :default => 0
			t.integer		:sequence  # for ordering questions ?
			t.timestamps
		end
		
		create_table :quizzings, :force => true do |t|
			t.references	:quiz
			t.references	:user
			t.references	:quiz_question # Last question for resume?
			t.integer		:score # can derive this from answerings?
			t.timestamps
		end
		
		add_index :quizzes, [ :lesson_id, :creator_id ]
		add_index :quiz_answers, :quiz_question_id
		add_index :quiz_answerings, :quizzing_id
		add_index :quiz_answerings, :quiz_question_id
		add_index :quiz_answerings, :quiz_answer_id
		add_index :quiz_questions, [ :quiz_id, :sequence ]
		add_index :quizzings, [ :quiz_id, :user_id ]
		add_index :quizzings, :quiz_question_id
		
		
	end
	
end
