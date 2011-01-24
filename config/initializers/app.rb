APP_NAME 			= "Cherry Tree"
APP_DESCRIPTION		= "Cherry Tree is a behavior game for kids"

APP_ROUTE_PATHS		= Rails.application.routes.routes
APP_SSL_PROTOCOL	= Rails.env.production? ? 'https' : 'http'