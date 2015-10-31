RSpec.configure do |config|
  config.before(fake_environment: true) do
    allow(ENV).to receive(:fetch) do |key|
      key.downcase
    end
  end
end
