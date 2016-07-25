require 'spec_helper'
require 'ostruct'
require_relative '../../lib/twitter_credentials'

RSpec.describe TwitterCredentials do
  let(:fake_user) { double(:user, id: 1) }
  let(:fake_client) { double(:client, user: fake_user) }
  let(:env) { double(:env, test?: false) }

  subject(:credentials) { TwitterCredentials.new('consumer_key', 'consumer_secret', 'access_token', 'access_token_secret') }

  describe '.create' do
    let(:env) { {'TWITTER_CONSUMER_KEY' => 1, 'TWITTER_CONSUMER_SECRET' => 2, 'TWITTER_ACCESS_TOKEN' => 3, 'TWITTER_ACCESS_TOKEN_SECRET' => 4} }

    it 'configures a new instance of the class with values from the environment' do
      expect(TwitterCredentials.create(env).to_h).to eq(
        consumer_key: 1,
        consumer_secret: 2,
        access_token: 3,
        access_token_secret: 4,
      )
    end
  end

  describe '#twitter_uid' do
    before { allow(credentials).to receive(:client).and_return(fake_client) }

    context 'when in test mode' do
      let(:env) { double(:env, test?: true) }

      it 'returns a fake user id' do
        expect(credentials.twitter_uid(env)).to eq('FAKE_TWITTER_UID')
      end
    end

    context 'when any of the twitter credentials are not defined in the environment' do
      subject(:credentials) { TwitterCredentials.new('consumer_key', nil, 'access_token', 'access_token_secret') }

      it 'returns a fake user id' do
        expect(credentials.twitter_uid(env)).to eq('FAKE_TWITTER_UID')
      end
    end

    context 'when not in test mode' do
      it 'returns the current user id' do
        expect(credentials.twitter_uid(env)).to eq('1')
      end
    end
  end

  describe '#client' do
    it 'configures a new instance of the client with twitter credentials' do
      expect(credentials.client(OpenStruct).to_h).to eq(
        consumer_key: 'consumer_key',
        consumer_secret: 'consumer_secret',
        access_token: 'access_token',
        access_token_secret: 'access_token_secret',
      )
    end
  end

  describe '#stream' do
    it 'configures a new instance of the streaming client with twitter credentials' do
      expect(credentials.stream(OpenStruct).to_h).to eq(
        consumer_key: 'consumer_key',
        consumer_secret: 'consumer_secret',
        access_token: 'access_token',
        access_token_secret: 'access_token_secret',
      )
    end
  end
end
