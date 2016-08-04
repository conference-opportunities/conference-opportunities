source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'dotenv-rails', groups: [:development, :test]

# sassc-rails <= 1.2.1 is incompatible with Rails 5/Sprockets 4
gem 'sass-rails', require: false
gem 'sassc-rails', git: 'https://github.com/sass/sassc-rails'

gem 'coffee-rails'
gem 'dalli'
gem 'date_validator'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-sass'
gem 'jquery-rails'
gem 'omniauth-twitter'
gem 'pundit'
gem 'rails-i18n'
gem 'rails_admin-i18n'
gem 'rails_locale_detection'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'twitter'
gem 'uglifier', '>= 1.3.0'

# Rails 5 uses Rack 2, ergo Sinatra 2 is required wherever Sinatra 1 was
# Sinatra 2 needs the most recent rack-protection, which has not been released
gem 'rack-protection', git: 'https://github.com/sinatra/rack-protection'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra', require: false

# RailsAdmin is not compatible with Rails 5 yet, so use compatible forks
gem 'rails_admin', git: 'https://github.com/minifast/rails_admin', require: 'rails_admin'
gem 'remotipart', git: 'https://github.com/mshibuya/remotipart'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :staging, :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'rapporteur'
end

group :development do
  gem 'derailed'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'license_finder'
  gem 'pivotal_git_scripts'
  gem 'web-console', '~> 3.0'
end

group :development, :test do
  gem 'bullet'
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'parallel_tests'
  gem 'rspec-rails'
  gem 'teaspoon-jasmine'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'chromedriver-helper'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'launchy'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end

group :development, :staging do
  gem 'rack-mini-profiler', require: false
end
