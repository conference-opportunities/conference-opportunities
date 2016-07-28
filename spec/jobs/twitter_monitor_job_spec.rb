require 'rails_helper'

RSpec.describe TwitterMonitorJob, type: :job do
  let(:stream) { Twitter::Streaming::Client.new }
  let(:fake_credentials) { double(:credentials, stream: stream) }
  let(:event) { Twitter::Streaming::StallWarning.new(code: 'ff0000', message: 'go faster', percent_full: '100') }
  let(:fake_logger) { double(:logger, info: nil) }

  subject(:job) { TwitterMonitorJob.new }

  before do
    allow(Sidekiq::Logging).to receive(:logger).and_return(fake_logger)
    allow(stream).to receive(:user)
    allow(TwitterCredentials).to receive(:create).and_return(fake_credentials)
  end

  describe '#perform' do
    context 'when the streaming client does not emit any events' do
      it 'does not enqueue any jobs' do
        expect { job.perform }.not_to enqueue_job
      end
    end

    context 'when the streaming client emits an irrelevant event' do
      before { allow(stream).to receive(:user).and_yield(event) }

      it 'does not enqueue any jobs' do
        expect { job.perform }.not_to enqueue_job
      end
    end

    context 'when the streaming client emits a tweet' do
      let(:user_mention) { {screen_name: 'hihiconf', id: 123, id_str: '123', indices: [0], name: 'Hi and Hi Hi'} }
      let(:event) { Twitter::Tweet.new(id: 1, entities: {user_mentions: [user_mention]}) }

      before { allow(stream).to receive(:user).and_yield(event) }

      it 'enqueues a creation' do
        expect { job.perform }.to enqueue_job(CreateTweetJob).with(1, [123])
      end
    end

    context 'when the streaming client emits a tweet deletion' do
      let(:event) { Twitter::Streaming::DeletedTweet.new(id: 1) }

      before { allow(stream).to receive(:user).and_yield(event) }

      it 'enqueues a deletion' do
        expect { job.perform }.to enqueue_job(DeleteTweetJob).with(1)
      end
    end

    context 'when the streaming client emits a follow' do
      let(:user) { {id: 123} }
      let(:event) { Twitter::Streaming::Event.new(event: :follow, source: user, target: user) }

      before { allow(stream).to receive(:user).and_yield(event) }

      it 'enqueues a follow' do
        expect { job.perform }.to enqueue_job(ConferenceFollowJob).with(123)
      end
    end

    context 'when the streaming client emits an unfollow' do
      let(:user) { {id: 123} }
      let(:event) { Twitter::Streaming::Event.new(event: :unfollow, source: user, target: user) }

      before { allow(stream).to receive(:user).and_yield(event) }

      it 'enqueues a follow' do
        expect { job.perform }.to enqueue_job(ConferenceUnfollowJob).with(123)
      end
    end
  end
end
