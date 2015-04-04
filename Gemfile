source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'haml-rails'
gem 'enumerize'
gem 'authority'
gem 'bcrypt', '~> 3.1.7'
gem 'active_form', github: 'rails/actionform', ref: '41ec958'
gem 'simple_form'
gem 'bootstrap-sass'
gem 'state_machine', git: 'https://github.com/seuros/state_machine.git'
gem 'draper'
gem 'russian'
gem 'carrierwave'
gem 'mini_magick'
gem 'rmagick'
gem 'datetimepicker-rails', git: 'git://github.com/zpaulovics/datetimepicker-rails.git', branch: 'master', submodules: true
gem 'js-routes'
gem 'i18n-js', git: 'https://github.com/fnando/i18n-js'
gem 'omniauth-google-oauth2'
gem 'omniauth-vkontakte'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'momentjs-rails', '>= 2.9',  :github => 'derekprior/momentjs-rails'
gem 'awesome_print'
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'configus'
gem 'foursquare2', github: 'nitinstp23/foursquare2', branch: :gemspec_fix
gem 'validates'

gem 'foundation-rails'
gem "autoprefixer-rails"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'unicorn-rails'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'foreman'

  gem 'guard-livereload', '~> 2.4', require: false
  gem "rack-livereload"

  # Access an IRB console on exception pages or by using <%= console %> in viewr
  gem 'web-console', '2.0.0.beta2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
  gem 'capistrano-sidekiq'
  gem 'capistrano-rvm'
  gem 'rvm-capistrano'
  gem 'capistrano-ssh-doctor', '~> 1.0'
  gem 'colorize', '0.6.0'
  gem 'quiet_assets'
  gem 'better_errors'
end

group :test do
  gem 'simplecov', require: false
  gem 'tconsole', github: 'ulmic/tconsole', branch: 'rails4'
  gem 'coveralls', require: false
end
