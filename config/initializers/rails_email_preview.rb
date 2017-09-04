require 'rails_email_preview'

unless Rails.env.test?
  Rails.application.config.to_prepare do
    RailsEmailPreview.preview_classes = RailsEmailPreview.find_preview_classes('app/mailer_previews')
  end
end
