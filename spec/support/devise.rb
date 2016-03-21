OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers

  config.before(:suite) { Warden.test_mode! }

  config.before(:each) do |example|
    mapping = Devise.mappings[:organizer]

    if defined?(request)
      request.env["devise.mapping"] = mapping
    else
      Rails.application.env_config["devise.mapping"] = mapping
    end
  end

  config.after(:each) do
    Warden.test_reset!
  end
end
