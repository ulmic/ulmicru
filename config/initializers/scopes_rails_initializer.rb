require "#{Rails.root}/lib/middleware/scopes_rails_middleware.rb"

Rails.application.config.middleware.use ScopesRailsMiddleware
