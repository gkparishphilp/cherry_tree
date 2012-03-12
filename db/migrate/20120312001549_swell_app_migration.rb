class SwellAppMigration < ActiveRecord::Migration
	def change
		
		create_table :alt_emails do |t|
			t.references	:user
			t.string		:email
			t.string		:label # home, work, etc
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :alt_emails, :user_id
		
		create_table :attachments, :force => true do |t|
			t.references	:owner, :polymorphic => true, :null => false
			t.string		:attachment_type
			t.string		:name
			t.string		:format
			t.string		:path
			t.string		:filesize
			t.string		:origin
			t.string		:ip
			t.boolean		:remote, :default => false
			t.string		:status, :default => 'active'
			
			t.timestamps
		end

		add_index :attachments, ["owner_id", "owner_type"], :name => "fk_owner"

		create_table :categories do |t|
			t.references	:site
			t.string		:name
			t.string		:type  # ALlows to STI these -- e.g. forum_category, product_category, blog_category, etc.
			t.references	:parent
			t.integer		:lft
			t.integer		:rgt
			t.text			:description
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.integer		:seq
			t.string		:slug
			t.timestamps
		end
		
		add_index :categories, :site_id
		add_index :categories, :parent_id
		add_index :categories, :lft
		add_index :categories, :rgt
		add_index :categories, :slug, :unique => true
		
		create_table :categorizations do |t|
			t.references	:category
			t.references	:categorized, :polymorphic => true
			t.timestamps
		end
		
		add_index :categorizations, :category_id
		add_index :categorizations, :categorized_id
		add_index :categorizations, :categorized_type
		
		create_table :contacts do |t|
			t.references	:site
			t.references	:user
			t.references	:crash
			t.string		:subject
			t.string		:ip
			t.text			:content
			t.string		:contact_type # enqiry, sales lead, etc....
			t.timestamps
		end
		
		add_index :contacts, :site_id
		add_index :contacts, :user_id
		add_index :contacts, :crash_id
		
		create_table :crashes do |t|
			t.references	:site
			t.string		:message
			t.string		:requested_url
			t.string		:referrer
			t.text			:backtrace
			t.timestamps
		end
		
		add_index :crashes, :site_id
		
		create_table :delayed_jobs, :force => true do |t|
			t.integer  :priority, :default => 0	# Allows some jobs to jump to the front of the queue
			t.integer  :attempts, :default => 0	# Provides for retries, but still fail eventually.
			t.text     :handler					# YAML-encoded string of the object that will do work
			t.text     :last_error				# reason for last failure (See Note below)
			t.datetime :run_at					# When to run. Could be Time.zone.now for immediately, or sometime in the future.
			t.datetime :locked_at				# Set when a client is working on this object
			t.datetime :failed_at				# Set when all retries have failed (actually, by default, the record is deleted instead)
			t.string   :locked_by				# Who is working on this object (if locked)
			t.timestamps
		end
		
		add_index :delayed_jobs, [:priority, :run_at], :name => 'delayed_jobs_priority'
		
		create_table :display_elements do |t|
			t.references	:container, :polymorphic => true
			t.references	:widget # if widget
			t.references	:site_image
			t.references	:media, :polymorphic => true # ### Was SIte Image -- now to use media model for photos, videos, songs, etc. if image
			t.string		:title # for widgets?
			t.integer		:num_elements # for widgets
			t.string		:url # for linking images
			t.integer		:seq # for non-positioned elements 
			t.boolean		:fill # True for headings and images, false for paragraphs
			t.boolean		:positioned
			t.text			:copy
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :display_elements, [ :container_id, :container_type ]
		add_index :display_elements, :widget_id
		add_index :display_elements, :site_image_id
		add_index :display_elements, [ :media_id, :media_type ]
		
		
		create_table :email_campaigns do |t|
			t.references	:site
			t.references	:email_template
			t.string		:campaign_type # auto, on-demand
			t.string		:name
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :email_campaigns, :site_id
		add_index :email_campaigns, :email_template_id
		add_index :email_campaigns, :campaign_type
		
		
		create_table :email_campaign_lists do |t|
			t.references :email_campaign
			t.references :email_list
			t.timestamps
		end
	
		add_index :email_campaign_lists, :email_campaign_id
		add_index :email_campaign_lists, :email_list_id
		
		
		create_table :email_deliveries do |t|
			t.references	:user
			t.references	:email_message
			t.string		:status, :default => 'sent'
			t.string		:code
			t.datetime		:opened_at
			t.timestamps
		end
		
		add_index :email_deliveries, :user_id
		add_index :email_deliveries, :email_message_id
		add_index :email_deliveries, :code
		
		create_table :email_lists do |t|
			t.references	:site
			t.references	:user # who created the list
			t.string		:name
			t.string		:list_type
			t.string		:rule_joiner
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :email_lists, :site_id
		add_index :email_lists, :user_id
		
		create_table :email_list_rules do |t|
			t.references	:email_list
			t.string		:field
			t.string		:rule_logic
			t.string		:status => 'published'
			t.timestamps
		end
		
		add_index :email_list_rules, :email_list_id
		
		create_table :email_messages do |t|
			t.references	:email_campaign
			t.references	:sender, :polymorphic => true
			t.references	:site
			t.string		:message_type
			t.string		:subject
			t.text			:content
			t.datetime		:deliver_at
			t.string		:status, :defualt => 'published'
			t.timestamps
		end
		
		add_index :email_messages, :email_campaign_id
		add_index :email_messages, :site_id
		add_index :email_messages, [:sender_id, :sender_type]
		
		
		create_table :email_optins do |t|
			t.references	:user
			t.references	:email_list # just to track where came from if uplaoded
			t.references	:site
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :email_optins, :email_list_id
		add_index :email_optins, :user_id
		add_index :email_optins, :site_id
		
		
		create_table :email_site_optouts do |t|
			t.references	:user
			t.references	:site
			t.string		:status, :default => 'active'
			t.timestamps
		end
	
		add_index :email_site_optouts, [:user_id, :site_id]
		
		create_table :email_templates do |t|
			t.references	:email_campaign
			t.text			:content
			t.string		:status
			t.timestamps
		end
		
		add_index :email_templates, :email_campaign_id
		
		create_table :email_unsubscribings do |t|
			t.references	:email_campaign
			t.references	:user
			t.string		:status
			t.timestamps
		end
		
		add_index :email_unsubscribings, :email_campaign_id
		add_index :email_unsubscribings, :user_id
		
		
		create_table :object_subscriptions do |t|
			t.references	:user
			t.references	:site
			t.references	:parent_object, :polymorphic => true
			t.string		:status, :default => 'active'
			t.string		:subscription_type # real-time, daily, weekly, monthly, etc?
			t.string		:format # email, notification, etc.????
			t.string		:code # to unsubscribe
			t.timestamps
		end
		
		add_index :object_subscriptions, :user_id
		add_index :object_subscriptions, :parent_object_id
		add_index :object_subscriptions, :parent_object_type
		add_index :object_subscriptions, :code
		
		create_table :events do |t|
			t.references	:site
			t.references	:user
			t.string		:title
			t.text			:description
			t.datetime		:starts_at
			t.datetime		:ends_at
			t.string		:location
			t.boolean		:all_day
			t.string		:event_type
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.string		:slug
			t.timestamps
		end
		
		add_index :events, :site_id
		add_index :events, :user_id
		add_index :events, :slug, :unique => true
		
		create_table :filters do |t|
			t.references	:site
			t.references	:user # the person who added this filter
			t.string		:type
			t.string		:filter_value
			t.string		:match_type, :default => 'exact' # exact, fuzzy
			t.string		:status_to_apply, :default => 'spam' # spam, inappropriate, moderate
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :filters, :site_id
		add_index :filters, :user_id
		add_index :filters, :filter_value
		
		
		create_table :geo_addresses do |t|
			t.references	:owner, :polymorphic => true
			t.references	:geo_state
			t.references	:geo_country
			t.string		:address_type
			t.string		:title
			t.string		:first_name
			t.string		:last_name
			t.string		:street
			t.string		:street2
			t.string		:city
			t.string		:state_name
			t.string		:zip
			t.string		:phone
			t.boolean		:preferred, :default => false
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :geo_addresses, [ :owner_id, :owner_type ]
		add_index :geo_addresses, :geo_country_id
		add_index :geo_addresses, :geo_state_id
		
		create_table :geo_countries do |t|
			t.string   :name
			t.string   :abbrev
			t.timestamps
		end
		
		# No indexes necessary
		
		create_table :geo_states do |t|
			t.references	:geo_country
			t.string		:name
			t.string		:abbrev
			t.string		:country
			t.timestamps
		end
		
		add_index :geo_states, :geo_country_id
		
		create_table :links do |t|
			t.references	:site
			t.references	:owner, :polymorphic => true
			t.string		:url
			t.string		:title
			t.string		:link_type # purchase, misc
			t.string		:description
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.integer		:seq
			t.timestamps
		end
		
		add_index :links, [ :owner_id, :owner_type ]
		add_index :links, :link_type
		
		create_table :media do |t|
			t.references	:user
			t.references	:site
			t.references	:publisher
			t.references	:category
			t.string		:type # STI for book, song, video, etc.
			t.references	:parent # stuff for nested_set
			t.integer		:lft
			t.integer		:rgt
			t.string		:title
			t.string		:subtitle
			t.text			:description
			t.text			:content # used for media that can be stored right in the DB, also podcast transcripts, maybe someday blog
			t.text			:excerpt
			t.boolean		:explicit, :default => false
			t.boolean		:sticky, :default => false
			t.boolean		:comments_allowed, :default => true
			t.string		:style # for novel, noir, whatever
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.boolean		:featured, :default => false
			t.float			:cached_rating_avg, :default => 0
			t.integer		:cached_view_count, :default => 0
			t.datetime		:publication_date # when media was published
			t.datetime		:publish_at # when to show on the site
			t.integer		:seq # listing sequence
			t.string		:slug
			t.datetime		:modified_at # because updated_at is inadequate when caching stats, etc.
			t.timestamps
		end
		
		add_index :media, :site_id
		add_index :media, :user_id
		add_index :media, :category_id
		add_index :media, :publisher_id
		add_index :media, :slug, :unique => true
		
		
		create_table :messages do |t|
			t.references	:site
			t.references	:sender
			t.string		:subject
			t.text			:content
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :messages, :site_id
		add_index :messages, :sender_id
		
		create_table :message_deliveries do |t|
			t.references	:message
			t.references	:recipient
			t.boolean		:unread, :default => true
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :message_deliveries, :message_id
		add_index :message_deliveries, :recipient_id
		
		create_table :pages do |t|
			t.references	:site
			t.references	:template
			t.string		:url
			t.string		:title
			t.text			:description
			t.text			:content
			t.string		:redirect_path # where to send request if page is redirected
			t.string		:css
			t.boolean		:featured, :default => false
			t.string		:status, :default => 'published' # deleted, redirected
			t.string		:availability, :default => 'public'
			t.timestamps
		end
		
		add_index :pages, :site_id
		add_index :pages, :template_id
		add_index :pages, :url
		
		create_table :sessions do |t|
			t.references	:site
			t.references	:user
			t.text			:data
			t.string		:orig_ip
			t.string		:last_ip
			t.timestamps
		end
		
		add_index :sessions, :updated_at
		add_index :sessions, :site_id
		add_index :sessions, :user_id
		
		
		create_table :sites do |t|
			t.references	:user
			t.boolean		:app_host # the primary site that is hosting the app 
			t.string		:domain
			t.string		:name
			t.string		:display_name
			t.string		:tagline
			t.text			:description
			t.string		:comment_policy, :default => 'allow' # allow, review.  specifies whether comments require review to publish
			t.string		:default_avatar, :default => 'identicon' # wavatar, monsterID
			t.text			:analytics_code
			t.string		:http_username
			t.string		:http_password
			t.string		:points_name, :default => 'points' # what to call user points TODO -- maybe move this?
			t.string		:users_name, :default => 'user' # what to call users
			t.string		:status, :default => 'published'
			t.string		:redirect_path # to forward the entire site???
			t.string		:availability, :default => 'public' # TODO -- maybe implement someday as http_auth
			t.string		:contact_email
			t.string		:contact_phone
			t.timestamps
		end
		
		add_index :sites, :user_id
		add_index :sites, :name
		add_index :sites, :domain
		
		create_table :site_activities do |t|
			t.references	:user # the actor
			t.references	:site
			t.text			:content
			t.string		:status, :default => 'published'
			t.integer		:target_obj_id
		    t.string		:target_obj_type
		    t.integer		:trigger_obj_id
		    t.string		:trigger_obj_type
			t.timestamps
		end
		
		add_index :site_activities, :user_id
		add_index :site_activities, :site_id
		add_index :site_activities, :target_obj_id
		add_index :site_activities, :target_obj_type
		add_index :site_activities, :trigger_obj_id
		add_index :site_activities, :trigger_obj_type
		
		create_table :site_images do |t|
			t.references	:site
			t.string		:name
			t.string		:status, :default => 'published' # use profile for profile_pic
			t.timestamps
		end
		
		add_index :site_images, :site_id
		
		create_table :site_memberships do |t|
			t.references	:site
			t.references	:user
			t.string		:role # member, contributor, moderator, admin
			t.string		:name
			t.string		:display_name
			t.string		:display_field, :default => 'name' # name, display_name, full_name
			t.integer		:score, :default => 0
			t.integer		:points_earned, :default => 0 # Lifetime
			t.integer		:points_balance, :default => 0
			t.integer		:level, :default => 0
			t.string		:website_url
			t.text			:bio
			t.text			:sig
			t.string		:sort_pref, :default => 'asc'
			t.string		:password_digest  # For Rails 3.1 BCrypt Authentication
			t.string		:md5_password_hash # For backwards-compatibility
			t.string		:sha1_password_hash # For backwards-compatibility
			t.string		:sha1_password_salt # For backwards-compatibility
			t.string		:remember_token
			t.datetime		:remember_token_expires_at
			t.string		:activation_code
			t.datetime		:activated_at
			t.string		:invitation_code
			t.string		:password_hint
			t.string		:password_hint_response
			t.string		:slug
			t.string		:orig_ip
			t.string		:last_ip
			t.string		:status, :default => 'active' # first, confirmed, spammer, etc.?
			t.datetime		:modified_at # because updated_at is inadequate when caching stats, etc.
			t.timestamps
		end
		
		add_index :site_memberships, :site_id
		add_index :site_memberships, :user_id
		add_index :site_memberships, :activation_code
		add_index :site_memberships, :remember_token
		add_index :site_memberships, :invitation_code
		add_index :site_memberships, :slug, :unique => true
		
		create_table :site_metatags do |t|
			# Just a way for sites to add metatags to their header like google verification, etc.
			t.references	:site
			t.string		:name
			t.string		:content
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :site_metatags, :site_id
		
		create_table :site_modules do |t|
			# defines all the modules that are available
			t.string		:name
			t.string		:display_name
			t.text			:description
			t.string		:subscription_level
		end
		
		create_table :site_module_ownings do |t|
			t.references	:site
			t.references	:site_module
		end
		
		add_index :site_module_ownings, :site_id
		add_index :site_module_ownings, :site_module_id
		
		create_table :site_module_helps do |t|
			t.references	:site_module
			t.string		:action # to bind to specific views like new vs edit
			t.text			:content
			t.timestamps
		end
		
		add_index :site_module_helps, :site_module_id
		add_index :site_module_helps, :action
		
		create_table :site_module_controller_mappings do |t|
			# a mapping of controllers to site modules
			# for instance, the Forum module includes forums_controller, topics_controller, and posts_controller
			t.references	:site_module
			t.string		:controller_name
		end
		
		add_index :site_module_controller_mappings, :site_module_id
		add_index :site_module_controller_mappings, :controller_name
		
		create_table :site_module_template_mappings do |t|
			# makes it possible to apply a template to a specific module
			t.references	:site
			t.references	:site_module
			t.references	:template
			t.timestamps
		end
		
		add_index :site_module_template_mappings, :site_id
		add_index :site_module_template_mappings, :site_module_id
		add_index :site_module_template_mappings, :template_id
		
		
		create_table :social_accounts do |t|
			t.references	:user
			t.string		:provider
			t.string		:name
			t.string		:uid
			t.string		:auth_token
			t.string		:auth_secret
			t.string		:status, :default => 'active'

			t.timestamps
		end
		
		add_index :social_accounts, :user_id
		add_index :social_accounts, :provider
		add_index :social_accounts, :uid
	
	
		create_table :stat_events do |t|
			t.references	:statable, :polymorphic => true
			t.string		:event
			t.string		:ip
			t.string		:extra_data # legacy?
			t.timestamps
		end
		
		add_index :stat_events, [ :statable_id, :statable_type ]
		add_index :stat_events, :event
		
		create_table :stat_summaries do |t|
			t.references	:statable, :polymorphic => true
			t.string		:event
			t.integer		:count_total, :default => 0
			t.datetime		:period_starts_at
			t.datetime		:period_ends_at
			t.timestamps	# when the batch was run
		end
		
		add_index :stat_summaries, [ :statable_id, :statable_type ]
		add_index :stat_summaries, :event
				
		create_table :style_specs do |t|
			t.references	:owner, :polymorphic => true # page, layout_container, display_element
			t.string		:spec_type # templates at least may have yield_style, container_style, or body_style
			t.integer		:top, :default => 0
			t.integer		:lft, :default => 0 # left seems to be a mysql reserved word
			t.integer		:width, :default => 0
			t.integer		:height, :default => 0
			t.string		:overflow, :default => ''
			
			t.integer		:border_top, :default => 0
			t.integer		:border_bottom, :default => 0
			t.integer		:border_left, :default => 0
			t.integer		:border_right, :default => 0
			t.string		:border_color, :default => ''
			t.string		:border_style, :default => 'solid' # dashed, dotted, double, groove, inset, outset, hidden, ridge, solid

			t.integer		:padding_top, :default => 0
			t.integer		:padding_bottom, :default => 0
			t.integer		:padding_left, :default => 0
			t.integer		:padding_right, :default => 0
			
			t.integer		:margin_top, :default => 0
			t.integer		:margin_bottom, :default => 0
			t.integer		:margin_left, :default => 0
			t.integer		:margin_right, :default => 0
			
			t.string		:font, :default => ''
			t.integer		:font_size, :default => 0
			t.string		:color, :default => '' # font color
			t.string		:text_align, :default => ''
			t.string		:link_color, :default => ''
			t.string		:text_align, :default => ''
			t.string		:bg_color, :default => ''
			t.string		:bg_repeat, :default => ''
			t.string		:css_classes, :default => '' # refer to _app_effects_classes.sass
			t.string		:custom_css, :default => ''
			t.timestamps
		end
		
		add_index :style_specs, [ :owner_id, :owner_type ]
		
		create_table :tags do |t|
			t.references	:site
			t.string		:name
			t.timestamps
		end
		
		add_index	:tags, :site_id

		create_table :taggings do |t|
			t.references	:tag
			t.references	:taggable, :polymorphic => true
			t.references	:tagger, :polymorphic => true
			t.string		:context
			t.timestamps
		end

		add_index :taggings, :tag_id
    	add_index :taggings, [:taggable_id, :taggable_type, :context]
		
		create_table :templates do |t|
			t.references	:user # the author or creator of the template
			t.string		:name
			t.string		:display_name
			t.string		:layout
			t.text			:description
			t.boolean		:public
			t.string		:container_class, :default => 'container' # 'container' is 'fixed' # add ability to be 'container-fluid'
			t.string		:body_bg_repeat
			t.string		:yield_bg_repeat
			t.integer		:price
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.timestamps
		end
		
		add_index :templates, :user_id
		
		create_table :template_assets do |t|
			t.references	:template
			t.string		:asset_type # css, javascript, other??
			t.string		:path
			t.timestamps
		end
		
		add_index :template_assets, :template_id
		
		create_table :template_containers do |t|
			t.references	:template
			t.string		:container_type
			t.string		:name   # maybe going to try to use this for custom classes like 'sidebar', 'topbar', etc
			t.boolean		:positioned, :default => false  ### Todo -- maybe someday allow containers to position like elements?
			t.integer		:seq
			t.text			:copy
			t.timestamps
		end
		
		add_index :template_containers, :template_id
		
		create_table :template_ownings do |t|
			t.references	:template
			t.references	:site
			t.boolean		:applied, :default => false
			t.string		:status, :default => 'published'  # publisheded, deleted
			t.timestamps
		end
		
		add_index :template_ownings, :template_id
		add_index :template_ownings, :site_id
		
		create_table :themes do |t|
			t.references	:user # the user who created the theme
			t.string		:name
			t.string		:display_name
			t.text			:description
			t.string		:font
			t.integer		:font_size
			t.string		:body_bg_repeat, :default => 'repeat'
			t.string		:container_bg_repeat, :default => 'repeat'
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.timestamps
		end
		
		add_index :themes, :user_id
		add_index :themes, :name
		
		create_table :theme_colors do |t|
			t.references	:theme
			t.string		:name 
			t.text			:description
			t.string		:selector # the html element and or class e.g. input, p, a, h1, a:hover, .btn etc.
			t.string		:color_type, :default => 'color' # color or background-color
			t.string		:value # e.g. #555
			t.timestamps
		end
		
		add_index :theme_colors, :theme_id
		
		create_table :theme_ownings do |t|
			t.references	:theme
			t.references	:site
			t.boolean		:applied, :default => false
			t.string		:status, :default => 'published'   # published, deleted
			t.timestamps
		end
		
		add_index :theme_ownings, :theme_id
		add_index :theme_ownings, :site_id
		
		create_table :users do |t|
			t.references	:site # site user ORIGINALLY joined or captured
			t.string		:email
			t.string		:first_name
			t.string		:last_name
			t.datetime		:birthday
			t.string		:gender
			t.string		:orig_ip
			t.string		:last_ip
			t.string		:slug
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		add_index :users, :email
		add_index :users, :site_id
		add_index :users, :slug, :unique => true
		
		create_table :user_badges do |t|
			t.references	:site
			t.string		:name
			t.string		:display_name
			t.text			:description
			t.string		:badge_type
			t.integer		:level_required
			t.integer		:points_required
			t.text			:requirement # code to eval
			t.string		:status, :default => 'published'
			t.string		:availability, :default => 'public'
			t.timestamps
		end
		
		add_index :user_badges, :site_id
		add_index :user_badges, :name
		
		create_table :user_badgings do |t|
			t.references	:user
			t.references	:user_badge
			t.references	:site
			t.timestamps
		end
		
		add_index :user_badgings, :user_id
		add_index :user_badgings, :user_badge_id
		add_index :user_badgings, :site_id
		
		create_table :user_content do |t|
			t.references		:site # cache site for lookup performance
			t.references		:user
			t.references		:parent_object, :polymorphic => true
			t.references		:parent
			t.integer			:lft
			t.integer			:rgt
			t.string			:type  # STI
			t.string			:title # title or subject
			t.text				:content
			t.string			:ip
			t.string			:website_url
			t.integer			:score # for reviews
			t.integer			:cached_view_count # for forums
			t.string			:slug # forum topics, posts have friendly ID
			t.boolean			:comments_allowed # for locking forum threads
			t.boolean			:sticky # for forum topics
			t.string			:status, :default => 'published'
			t.datetime			:modified_at # because updated_at is inadequate when caching stats, etc.
			t.timestamps
		end
		
		add_index	:user_content, :site_id
		add_index	:user_content, :user_id
		add_index	:user_content, [ :parent_object_id, :parent_object_type ]
		add_index	:user_content, :parent_id
		add_index	:user_content, :slug
		
		create_table :user_notifications do |t|
			t.references	:site
			t.references	:site_activity # may just subscribe a user to a site_activity
			t.references	:user
			t.references	:source_user
			t.text			:content
			t.boolean		:unread, :default => true
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :user_notifications, :site_id
		add_index :user_notifications, :site_activity_id
		add_index :user_notifications, :user_id
		add_index :user_notifications, :source_user_id
		
		create_table :user_profile_fields do |t|
			t.references	:site
			t.string		:name
			t.string		:display_name
			t.string		:field_type
			t.integer		:seq
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :user_profile_fields, :site_id
		add_index :user_profile_fields, :name
		
		create_table :user_profile_values do |t|
			t.references	:user_profile_field
			t.references	:user
			t.references	:site
			t.text			:content
			t.timestamps
		end
		
		add_index :user_profile_values, :user_profile_field_id
		add_index :user_profile_values, :user_id
		
		create_table :votes do |t|
			t.references	:user
			t.references	:votable, :polymorphic => true
			t.integer		:score
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :votes, :user_id
		add_index :votes, [:votable_id, :votable_type]
		
		create_table :widgets do |t|
			t.string		:name
			t.string		:display_name
			t.text			:description
			t.references	:site_module # TODO implement, int the future reference a modules table?
			t.string		:widget_type
			t.string		:status, :default => 'published'
			t.timestamps
		end
		
		add_index :widgets, :name
		add_index :widgets, :site_module_id
		
		
	end

end

