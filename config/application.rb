require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Hack to allow this app to monkey-patch Engine App classes
require 'active_support/dependencies'
module ActiveSupport::Dependencies
	alias_method :require_or_load_without_multiple, :require_or_load
	def require_or_load( file_name, const_path=nil )
		if file_name.starts_with?( Rails.root.to_s + '/app' )
			relative_name = file_name.gsub( Rails.root.to_s, '' )
			@engine_paths ||= CherryTree::Application.railties.engines.collect{ |engine| engine.config.root.to_s }
			@engine_paths.each do |path|
				engine_file = File.join( path, relative_name )
				require_or_load_without_multiple( engine_file, const_path ) if File.file?( engine_file )
			end
		end
		require_or_load_without_multiple( file_name, const_path )
	end
end

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module CherryTree
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
	config.active_record.observers = :user_content_observer, :media_observer, :user_observer, :site_membership_observer, :filter_observer
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
