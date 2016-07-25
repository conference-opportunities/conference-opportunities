class TwitterMonitorJob < ActiveJob::Base
  queue_as :default

  class NullEvent
    def self.from_event(event)
      Sidekiq::Logging.logger.info("Unhandled streaming event: #{event.inspect}")
    end
  end

  def perform
    TwitterCredentials.create.stream.user(with: 'user') do |event|
      {
        Twitter::Tweet => CreateTweetJob,
        Twitter::Streaming::DeletedTweet => DeleteTweetJob,
      }.fetch(event.class, NullEvent).from_event(event)
    end
  end
end
