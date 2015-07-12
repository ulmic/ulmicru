require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ulmicru
  class Application < Rails::Application
    config.autoload_paths += Dir[
      "#{config.root}/lib/**/"
    ]
    config.active_record.raise_in_transactional_callbacks = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :ru
    config.assets.enabled = true
    config.assets.initialize_on_precompile = true
    config.assets.version = '1.0'
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.paths << Rails.root.join("app", "assets", "*.ico")
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.generators do |g|
      g.template_engine :haml
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.decorator false
    end
    config.time_zone = 'Moscow'
    ActionDispatch::Reloader.to_prepare do
      load Rails.root.join('lib/configus.rb')
    end
  end
end
