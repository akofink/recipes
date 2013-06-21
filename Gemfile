ruby '2.0.0'

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

# Use sqlite3 as the database for Active Record
group :test do
  gem 'sqlite3'
  gem 'guard-rails'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

group :production do
  # For Heroku Rails Integration
  gem 'rails_12factor'
end

group :production, :development do
  gem 'pg'
end

gem "twitter-bootstrap-rails"
gem "less-rails"
gem "therubyracer"
gem 'bootstrap-sass-rails'
gem 'sass-rails'
gem 'sass'
gem 'redcarpet'
gem 'cancan'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'debugger', group: [:development, :test]
