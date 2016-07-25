Rails.application.config.application_twitter_id = if ENV.has_key?('TWITTER_UID')
    ENV['TWITTER_UID']
  else
    requested_twitter_uid = TwitterCredentials.create.twitter_uid
    Rails.logger.info("Requested UID from Twitter; to cache, set TWITTER_UID=#{requested_twitter_uid} in .env")
    requested_twitter_uid
  end
