require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<TWITTER_CONSUMER_KEY>') { ENV['TWITTER_CONSUMER_KEY'] }
  c.filter_sensitive_data('<TWITTER_CONSUMER_SECRET>') { ENV['TWITTER_CONSUMER_SECRET'] }
  c.filter_sensitive_data('<TWITTER_ACCESS_TOKEN>') { ENV['TWITTER_ACCESS_TOKEN'] }
  c.filter_sensitive_data('<TWITTER_ACCESS_TOKEN_SECRET>') { ENV['TWITTER_ACCESS_TOKEN_SECRET'] }
  c.filter_sensitive_data('<GOOGLE_MAPS_API_KEY>') { ENV['GOOGLE_MAPS_API_KEY'] }
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'
end
