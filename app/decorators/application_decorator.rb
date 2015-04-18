class ApplicationDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
end
