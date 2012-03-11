CherryTree::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

  # Set cache directory to public/cache
  config.action_controller.page_cache_directory = Rails.public_path + '/cache'

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Set mailer to Amazon SES
  config.action_mailer.delivery_method = :ses

#	config.action_mailer.delivery_method = :smtp
#	config.action_mailer.smtp_settings = {
#	    :address        => "localhost",
#	    :port           =>  25,
#	    :domain         => "backmybook.com"
#	}

#	config.action_mailer.default_url_options = {
#	    :host   => 'localhost:3000'
#	}


  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin


	config.after_initialize do
		Amazon::Ecs.configure do |options| 
			options[:associate_tag] = 'thecherrytree-20'
			options[:AWS_access_key_id] = AMAZON_ID
			options[:AWS_secret_key] = AMAZON_SECRET
		end
	end
end

