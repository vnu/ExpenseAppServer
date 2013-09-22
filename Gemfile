source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgres as the database for Active Record
gem "pg", "~> 0.17.0"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc'
end

group :development do
  gem "watchr"
  gem "annotate", "~> 2.5.0" # For Populating model Comments
  gem "better_errors", "~> 1.0.1"
  gem "binding_of_caller", "~> 0.7.2"
  gem "localtunnel", "~> 0.3"
  gem "railroady", "~> 1.1.1"
  gem "meta_request", "~> 0.2.8"
  gem "rails-footnotes", "~> 3.7.9"
  gem "zeus", "~> 0.13.3"
  gem "jazz_hands", "~> 0.5.1"
  gem "pry-rescue", "~> 1.1.1"

  gem "migrate-well"                     # rake db:migrate:well will run annotate automatically afterwards.
  gem "rspec-rails"
  gem "fabrication", "~> 2.8.1"
  gem "capybara", "~> 2.1.0" #updated on Mar 28,2013 for Integration tests

  gem 'rb-fsevent' #if RUBY_PLATFORM.downcase.include?("darwin") # has to be commented else deploy to Heroku fails
  gem 'growl' #if RUBY_PLATFORM.downcase.include?("darwin")
  gem 'guard'
  gem 'guard-annotate'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem "tddium"
  gem 'foreman'
  gem "webrat"
  gem "quiet_assets"
  gem "poltergeist"
end

group :test do
  gem 'test-unit'
  gem "watchr"
  gem "rspec-rails"
  gem "valid_attribute"
  gem "fabrication", "~> 2.8.1"
  gem "capybara", "~> 2.1.0" #updated on Mar 28,2013 for Integration tests
  gem "webmock"
  gem "spork"
  gem "autotest"
  gem "autotest-rails-pure"
  gem "autotest-growl"
  #gem "autotest-fsevent"
  gem "shoulda"
  gem "fuubar"
  gem "launchy"
  gem "email_spec"
  gem "escape_utils"
  gem "timecop"
  gem "sham_rack"
  gem "taps"
  gem "no_peeping_toms"
  gem "simplecov"
  gem "database_cleaner"
  # gem "capybara-webkit"
  gem 'resque_spec'
  gem "selenium-webdriver", ">= 2.34.0"
  gem "poltergeist"
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
 gem 'unicorn'

# Use Capistrano for deployment
 gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
