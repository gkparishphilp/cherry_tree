class SiteBase < ActiveRecord::Migration
	# THis migration sets up the basic components of the website: site object, contacts, crashes, stats, etc...
	def self.up
		
		create_table :contacts, :force => true do |t|
			t.references	:site
			t.string		:email
			t.string		:subject
			t.string		:ip
			t.integer		:crash_id
			t.text			:content
			t.timestamps
		end
		
		create_table :crashes, :force => true do |t|
			t.references	:site
			t.string		:message
			t.string		:requested_url
			t.string		:referrer
			t.text			:backtrace
			t.timestamps
		end
		
		create_table :raw_stats, :force => true do |t|
			t.references	:statable, :polymorphic => true
			t.string		:name
			t.string		:ip
			t.integer		:count, :default => 0
			t.string		:extra_data
			t.timestamps
		end
		
		create_table :sites do |t|
			t.string		:name
			t.string		:domain
			t.string		:status, :default => 'active'
			t.timestamps
		end
		
		create_table :static_pages, :force => true do |t|
			t.references	:site
			t.string		:title
			t.string		:description
			t.string		:permalink
			t.string		:redirect_path
			t.text			:content
			t.timestamps
		end
		
		add_index :contacts, :email
		add_index :contacts, :crash_id
		add_index :raw_stats, :statable_id
		add_index :sites, :domain
		add_index :static_pages, :site_id
		add_index :static_pages, :permalink
		
	end

	def self.down
		
		drop_table	:contacts
		drop_table	:crashes
		drop_table	:raw_stats
		drop_table	:sites
		drop_table	:static_pages
		
	end
end
