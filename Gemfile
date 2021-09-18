source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rake'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'dotenv-rails', '~> 2.7.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'mocha'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Introducing react (18/09/2021)
gem 'graphql'
gem 'react-rails'

# gem 'shopify_app', '~> 17.1.0'
gem 'shopify_app', '~> 18.0.2'

# additional
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'
gem 'metamagic'
gem 'simple_form'
gem "font-awesome-rails"
gem 'will_paginate'
gem 'curb'
gem 'best_in_place'
gem 'actionview'
gem 'jquery-turbolinks'

gem 'sweet-alert-confirm'
gem 'sweetalert-rails', '~> 1.1', '>= 1.1.3' # added on error

# additional experimental extras
gem 'twitter-bootstrap-rails'
# gem 'devise' # disable until needed again
gem 'gravatarify'
gem 'bootstrap-sass'
gem 'figaro'
gem 'thor'
gem 'rack-cors', :require => 'rack/cors'
gem 'sucker_punch'
gem 'cocoon'
gem 'delayed_job_active_record'
gem 'daemons'

# packages above this line works fine
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'json'
gem 'pg', '~> 0.20'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'
  gem 'spring'
  gem 'foreman'
  gem 'better_errors'
  gem 'pry'
  gem 'awesome_print'
  gem "binding_of_caller"
  gem 'shopify-cli' #removed '1.10.0'
end

group :test do
  # Use sqlite3 as the database for Active Record
  gem 'spring'
  gem 'foreman'
  gem 'better_errors'
  gem 'pry'
  gem 'awesome_print'
  gem "binding_of_caller"
  gem 'shopify-cli' #removed '1.10.0'
end



gem 'graphiql-rails', group: :development