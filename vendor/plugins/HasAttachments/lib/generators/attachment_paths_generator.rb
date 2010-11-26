require 'rails/generators'

class AttachmentPathsGenerator < Rails::Generators::Base

	include HasAttachments::AttachmentLib
  
	def self.source_root
		@source_root ||= File.join(File.dirname(__FILE__), 'templates')
	end
	
	def create_paths
		unless File.exists? PUBLIC_ATTACHMENT_PATH
			create_directory PUBLIC_ATTACHMENT_PATH 
			puts "Created Public Path at:\n #{PUBLIC_ATTACHMENT_PATH }"
		end
		unless File.exists? PRIVATE_ATTACHMENT_PATH || PRIVATE_ATTACHMENT_PATH.blank?
			create_directory PRIVATE_ATTACHMENT_PATH 
			puts "Created Private Path at:\n #{PRIVATE_ATTACHMENT_PATH }"
		end
	end
  
end