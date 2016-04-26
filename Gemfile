source 'https://rubygems.org'
ruby File.read(File.expand_path('../.ruby-version', __FILE__)).strip

gem 'rails', '4.2.6'
gem 'pg'

gem 'date_validator'
gem 'devise'
gem 'font-awesome-sass'
gem 'haml-rails'
gem 'jquery-rails'
gem 'omniauth-twitter'
gem 'pundit'
gem 'rails_admin'
gem 'sass-rails', '~> 5.0'
gem 'twitter'
gem 'uglifier', '>= 1.3.0'

gem 'byebug', groups: [:development, :test]
gem 'dotenv-rails', groups: [:development, :test]

group :development do
  gem 'web-console', '~> 3.0'
  gem 'pivotal_git_scripts'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end
