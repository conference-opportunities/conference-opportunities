require 'axe/rspec'

Capybara::Axe.configure do |config|
  config.skip_paths << %r{conferences/[^/]*/listing}
  config.skip_paths << %r{conferences/[^/]*/detail}
  config.skip_paths << %r{conferences/[^/]*/structure}
  config.skip_paths << %r{admin}

  config.skip_rules << :'best-practice'
end

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    allow_any_instance_of(Capybara::Session).to receive(:visit).and_wrap_original do |original, *args|
      original.call(*args)
      unless Capybara::Axe.configuration.skip?(current_path)
        expect(page).to be_accessible.according_to(*Capybara::Axe.configuration.rules)
      end
    end

    allow_any_instance_of(Capybara::Session).to receive(:click_on).and_wrap_original do |original, *args|
      original.call(*args)
      unless Capybara::Axe.configuration.skip?(current_path)
        expect(page).to be_accessible.according_to(*Capybara::Axe.configuration.rules)
      end
    end
  end
end
