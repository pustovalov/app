source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'haml', '~> 4.0.7'
gem 'simple_form'
gem 'sorcery'
gem 'email_validator'
gem 'paperclip', github: 'thoughtbot/paperclip', branch: 'master'
gem 'aws-sdk', '>= 2.0.0'
gem 'figaro'
gem 'pry', require: false
gem 'pry-rails', require: false
gem 'pry-remote', require: false
gem 'pry-coolline', require: false
gem 'bugsnag'
gem 'text'
gem 'whenever', require: false
gem 'http_accept_language'
gem 'puma'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
end

group :development, :test do
  gem 'byebug', '~> 8.0', '>= 8.0.1'
  gem 'brakeman'
  gem 'pry-byebug', '~> 3.2', require: false
  gem 'parallel_tests'
  gem 'travis'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'rake'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: false
end

# specify ruby version for heroku
ruby "2.3.0"
