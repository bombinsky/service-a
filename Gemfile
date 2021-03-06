source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# dotenv-rails
gem 'dotenv-rails', groups: [:development, :test]
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Twitter gem
gem 'twitter'
# Omniauth Twitter gem
gem 'omniauth-twitter'
# Bootstrap form
gem 'bootstrap_form', '~> 4.0'
# Postrgres
gem 'pg'
# Bunny
gem 'bunny', '>= 2.14.1'
# Sneakers workers
gem 'sneakers'
# final_redirect_url
gem 'final_redirect_url'
# final_redirect_url
gem 'mechanize'
# draper
gem 'draper'
# faraday
gem 'faraday'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Factory Bot Rails
  gem 'factory_bot_rails'
  # Rspec rails
  gem 'rspec-rails', '~> 4.0.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'pronto-flay', require: false
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-brakeman', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'database_cleaner-active_record'
  gem 'webmock'
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
