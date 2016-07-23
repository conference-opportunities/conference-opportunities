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
      it 'does not create any tweets' do
        expect { job.perform }.not_to change(Tweet, :count)
      end
    end

    context 'when there is a tweet mentioning an existing conference' do
      let!(:conference) { Conference.create!(uid: 123, twitter_handle: 'hihiconf') }
      let(:user_mention) { {screen_name: 'hihiconf', id: 123, id_str: '123', indices: [0], name: 'Hi and Hi Hi'} }
      let(:tweets) { [Twitter::Tweet.new(id: 1, entities: {user_mentions: [user_mention]})] }

      it 'creates the tweet' do
        expect { job.perform }.to change { conference.reload.tweets.count }.by(1)
      end
    end

    context 'when there is a tweet mentioning two existing conferences' do
      let!(:first_conference) { Conference.create!(uid: 123, twitter_handle: 'hihiconf') }
      let!(:second_conference) { Conference.create!(uid: 456, twitter_handle: 'omgomgconf') }
      let(:first_mention) { {screen_name: 'hihiconf', id: 123, id_str: '123', indices: [0], name: 'Hi and Hi Hi'} }
      let(:second_mention) { {screen_name: 'omgomgconf', id: 456, id_str: '456', indices: [10], name: 'OMGOMG'} }
      let(:tweets) { [Twitter::Tweet.new(id: 1, entities: {user_mentions: [first_mention, second_mention]})] }

      it 'creates the tweet on the first conference' do
        expect { job.perform }.to change { first_conference.reload.tweets.count }.by(1)
      end

      it 'creates the tweet on the second conference' do
        expect { job.perform }.to change { second_conference.reload.tweets.count }.by(1)
      end
    end
  end
end
