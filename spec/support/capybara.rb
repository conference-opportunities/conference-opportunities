require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara::Screenshot.register_driver :chrome do |driver, path|
  driver.browser.save_screenshot(path)
end

RSpec.configure do |config|
  config.before(:each) do |example|
    if example.metadata[:chrome]
      Capybara.current_driver = :chrome
    else
      Capybara.current_driver = :poltergeist
    end
  end
end
