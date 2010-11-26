require 'rails/generators'
require 'rails/generators/migration'

class AttachmentsGenerator < Rails::Generators::Base
  
	include Rails::Generators::Migration
	include HasAttachments::AttachmentLib
  
	def self.source_root
		@source_root ||= File.join(File.dirname(__FILE__), 'templates')
	end
	
	# Implement the required interface for Rails::Generators::Migration.
	# taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
	def self.next_migration_number( dirname )
		if ActiveRecord::Base.timestamped_migrations
			Time.now.utc.strftime( "%Y%m%d%H%M%S" )
		else
			"%.3d" % ( current_migration_number( dirname ) + 1 )
		end
	end
  
	def create_migration_file
		migration_template 'migration.rb', 'db/migrate/attachments_migration.rb'
	end
  
	def create_model
		template "model.rb", File.join( 'app/models', "attachment.rb" )
	end
	
	def create_initializer
		template "initializer.rb", File.join( 'config/initializers', "attachments.rb" )
	end
	

end