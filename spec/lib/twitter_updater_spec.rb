require 'rails_helper'

RSpec.describe TwitterUpdater, :vcr do
  describe '.authenticated', :fake_environment do
    subject(:updater) { TwitterUpdater.authenticated }

    it 'returns a configured twitter updater' do
      expect(updater.to_h).to eq(
        consumer_key: TwitterCredentials::CONSUMER_KEY,
        consumer_secret: TwitterCredentials::CONSUMER_SECRET,
        access_token: TwitterCredentials::ACCESS_TOKEN,
        access_token_secret: TwitterCredentials::ACCESS_TOKEN_SECRET,
      )
    end
  end

  describe "#update_conferences" do
    it "creates a conference for every followed account" do
      expect {
        TwitterUpdater.authenticated.update_conferences
      }.to change(Conference, :count).by(1)

      expect(Conference.find_by(twitter_handle: "andconf")).to be_present
    end

    context "when the conference already exists" do
      before do
        TwitterUpdater.authenticated.update_conferences
      end

      it "does not create another conference" do
        expect {
          TwitterUpdater.authenticated.update_conferences
        }.to change(Conference, :count).by(0)
      end
    end

    context "when a conference exists that is no longer followed" do
      let!(:unfollowed_conference) do
        Conference.create!(twitter_handle: 'broconf', uid: '-1')
      end

      it "deletes the conference" do
        TwitterUpdater.authenticated.update_conferences
        expect(Conference.find_by(twitter_handle: 'broconf')).to be_nil
      end
    end
  end

  describe '#update_tweets' do
    context 'when there are no followed conferences' do
      it 'does not add any tweets' do
        expect {
          TwitterUpdater.authenticated.update_tweets
        }.not_to change(Tweet, :count)
      end
    end

    context 'when there is a followed conference' do
      let(:followed_conference) { Conference.find_by(twitter_handle: "andconf") }

      before do
        TwitterUpdater.authenticated.update_conferences
      end

      context 'when the since id is not provided' do
        it 'adds all tweets relating to the conference' do
          expect {
            TwitterUpdater.authenticated.update_tweets
          }.to change { followed_conference.reload.tweets.count }.by(2)
        end
      end

      context 'when the update has already been run once' do
        before { TwitterUpdater.authenticated.update_tweets }

        it 'does not add those tweets again' do
          expect {
            TwitterUpdater.authenticated.update_tweets
          }.not_to change { followed_conference.reload.tweets.count }
        end
      end

      context 'when the since id is provided' do
        it 'adds tweets relating to the conference after the specified tweet' do
          expect {
            TwitterUpdater.authenticated.update_tweets(678338428191170560)
          }.to change { followed_conference.reload.tweets.count }.by(1)
        end
      end
    end
  end
end
