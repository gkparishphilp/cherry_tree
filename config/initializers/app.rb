APP_NAME 			= "Cherry Tree"
APP_DESCRIPTION		= "Cherry Tree - a free service that improves parent child relationships"

APP_ROUTE_PATHS		= Rails.application.routes.routes
APP_SSL_PROTOCOL	= Rails.env.production? ? 'https' : 'http'

require 'core_class_monkey_patches'