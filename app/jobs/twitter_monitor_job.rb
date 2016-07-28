class TwitterMonitorJob < ActiveJob::Base
  queue_as :default

  class NullEvent
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def self.from_event(event)
      new(event).notify
    end

    def notify
      Sidekiq::Logging.logger.info("Unhandled streaming event: #<#{event.class.name} #{event.inspect}>")
    end
  end

  class EventUnwrapper
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def self.from_event(event)
      new(event.name).to_handler.from_event(event.target)
    end

    def to_handler
      {
        follow: ConferenceFollowJob,
        unfollow: ConferenceUnfollowJob,
      }.fetch(name, NullEvent)
    end
  end

  def perform
    TwitterCredentials.create.stream.user(with: 'user') do |event|
      {
        Twitter::Tweet => CreateTweetJob,
        Twitter::Streaming::DeletedTweet => DeleteTweetJob,
        Twitter::Streaming::Event => EventUnwrapper,
      }.fetch(event.class, NullEvent).from_event(event)
    end
  end
end
