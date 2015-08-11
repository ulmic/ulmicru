class ApplicationDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include RussianCases
end
