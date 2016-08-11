require 'axe/rspec'

RSpec.configure do |config|
  config.before(:each, :accessible, type: :feature) do
    allow_any_instance_of(Capybara::Session).to receive(:visit).and_wrap_original do |original, *args|
      original.call(*args)
      expect(page).to be_accessible
    end

    allow_any_instance_of(Capybara::Session).to receive(:click_on).and_wrap_original do |original, *args|
      original.call(*args)
      expect(page).to be_accessible
    end
  end
end
