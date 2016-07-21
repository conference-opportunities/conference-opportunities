require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Capybara.register_driver(:chrome) do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

module CapybaraGoogleAutoComplete
  def fill_in_autocomplete(css_id, options = {})
    fill_in css_id, with: ' '
    find("##{css_id}").native.send_keys(options[:with])
    page.execute_script %{ $('##{css_id}').trigger('focus') }
    expect(page).to have_selector('.pac-container .pac-item')
    find("##{css_id}").native.send_keys(:down)
    find("##{css_id}").native.send_keys(:enter)
    expect(page).to have_no_selector('.pac-container .pac-item')
  end
end

RSpec.configure do |config|
  config.include CapybaraGoogleAutoComplete
  config.before(:each, :browser) { Capybara.current_driver = :chrome }
  config.before(:each, :js) { Capybara.current_driver = :poltergeist }
end

begin
  real_stderr = $stderr
  $stderr = StringIO.new
  # Capybara::Screenshot does not support save_path (as of May 17, 2016)
  # see: https://github.com/jnicklas/capybara/issues/1688
  Capybara.save_and_open_page_path = File.expand_path('../../../tmp/capybara', __FILE__)
ensure
  $stderr = real_stderr
end
