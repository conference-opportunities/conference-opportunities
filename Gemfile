source 'https://rubygems.org'
ruby File.read(File.expand_path('../.ruby-version', __FILE__)).strip

gem 'rails', '4.2.6'
gem 'pg'

gem 'date_validator'
gem 'devise'
gem 'font-awesome-sass'
gem 'haml-rails'
gem 'i18n-tasks'
gem 'jquery-rails'
gem 'locale_setter'
gem 'omniauth-twitter'
gem 'pundit'
gem 'rack-contrib'
gem 'rails_admin'
gem 'sass-rails', '~> 5.0'
gem 'twitter'
gem 'uglifier', '>= 1.3.0'
gem 'virtus'

gem 'byebug', groups: [:development, :test]
gem 'dotenv-rails', groups: [:development, :test]

group :development do
  gem 'web-console', '~> 3.0'
  gem 'pivotal_git_scripts'
end

group :production do
  gem 'dalli'
  gem 'puma'
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'chromedriver-helper'
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'launchy'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end
