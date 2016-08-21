source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'dotenv-rails', groups: [:development, :test]

gem 'autoprefixer-rails'
gem 'bootstrap', '~> 4.0.0.alpha'
gem 'coffee-rails'
gem 'dalli'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-sass'
gem 'geocoder'
gem 'jquery-rails'
gem 'omniauth-twitter'
gem 'pundit'
gem 'rails-i18n'
gem 'rails_admin-i18n'
gem 'rails_locale_detection'
gem 'sass-rails', require: false
gem 'sassc-rails'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'twitter'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness'

# Rails 5 uses Rack 2; Sinatra 2 is required wherever Sinatra 1 was
gem 'sinatra', git: 'https://github.com/sinatra/sinatra', ref: '6b5a0ef3a4598366138fefe3f2b696ddeb371f3c', require: false

# RailsAdmin is not compatible with Rails 5 yet, so use compatible forks
gem 'rails_admin', '1.0.0.rc'
gem 'remotipart', git: 'https://github.com/mshibuya/remotipart', ref: '88d9a7d55bde66acb6cf3a3c6036a5a1fc991d5e'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :staging, :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'rapporteur'
end

group :development do
  gem 'derailed'
  gem 'guard-livereload', require: false
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
  gem 'axe-matchers'
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
