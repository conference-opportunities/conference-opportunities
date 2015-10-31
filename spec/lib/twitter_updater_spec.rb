require 'rails_helper'

RSpec.describe TwitterUpdater, :vcr, :fake_environment do
  describe '.authenticated' do
    subject(:updater) { TwitterUpdater.authenticated }

    it 'returns a configured twitter updater' do
      expect(updater.to_h).to eq(
        consumer_key: 'twitter_consumer_key',
        consumer_secret: 'twitter_consumer_secret',
        access_token: 'twitter_access_token',
        access_token_secret: 'twitter_access_token_secret',
      )
    end
  end

  describe "#update_all" do
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
  end
end
