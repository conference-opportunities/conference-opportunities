require 'rails_helper'

RSpec.describe CreateTweetsJob, type: :job do
  let(:client) { Twitter::REST::Client.new }
  let(:fake_credentials) { double(:credentials, client: client) }
  let(:tweets) { [] }

  subject(:job) { CreateTweetsJob.new }

  before do
    allow(client).to receive(:user_timeline).and_return(tweets)
    allow(TwitterCredentials).to receive(:create).and_return(fake_credentials)
  end

  describe '#perform' do
    context 'when there are no tweets in the user timeline' do
      it 'does not enqueue a tweet creation' do
        expect { job.perform }.not_to enqueue_job(CreateTweetJob)
      end
    end

    context 'when there is a tweet mentioning an existing conference' do
      let(:user_mention) { {screen_name: 'hihiconf', id: 123, id_str: '123', indices: [0], name: 'Hi and Hi Hi'} }
      let(:tweets) { [Twitter::Tweet.new(id: 1, entities: {user_mentions: [user_mention]})] }

      it 'enqueues a tweet creation' do
        expect { job.perform }.to enqueue_job(CreateTweetJob).with(1, [123])
      end
    end

    context 'when there is a tweet mentioning two existing conferences' do
      let(:first_mention) { {screen_name: 'hihiconf', id: 123, id_str: '123', indices: [0], name: 'Hi and Hi Hi'} }
      let(:second_mention) { {screen_name: 'omgomgconf', id: 456, id_str: '456', indices: [10], name: 'OMGOMG'} }
      let(:tweets) { [Twitter::Tweet.new(id: 1, entities: {user_mentions: [first_mention, second_mention]})] }

      it 'enqueues a tweet creation' do
        expect { job.perform }.to enqueue_job(CreateTweetJob).with(1, [123, 456])
      end
    end
  end
end
