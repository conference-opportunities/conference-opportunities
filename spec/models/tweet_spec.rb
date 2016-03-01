require 'rails_helper'

RSpec.describe Tweet do
  let(:conference) { Conference.create!(twitter_handle: 'tweetconf') }
  subject(:tweet) { conference.tweets.build(twitter_id: 1) }

  it { is_expected.to belong_to(:conference) }
  it { is_expected.to validate_presence_of(:conference) }
  it { is_expected.to validate_uniqueness_of(:twitter_id).scoped_to(:conference_id).case_insensitive }

  describe '.from_twitter' do
    let!(:conference) { Conference.create!(twitter_handle: 'andconf') }
    let(:conference_mention) do
      double(:user_mention, screen_name: conference.twitter_handle, id: 3237999706)
    end
    let(:user_mentions) { [conference_mention] }

    let(:tweet) do
      double(:tweet, id: 678338730684383232, user_mentions: user_mentions)
    end

    context 'when an existing conference is mentioned' do
      it 'returns a single tweet' do
        expect(Tweet.from_twitter(tweet).size).to eq(1)
      end

      it 'returns a valid tweet' do
        expect(Tweet.from_twitter(tweet).first).to be_valid
      end

      it 'creates a tweet with the correct attributes' do
        expect(Tweet.from_twitter(tweet).first.attributes).to include(
          'conference_id' => conference.id,
          'twitter_id' => '678338730684383232',
        )
      end

      context 'when a user that is not a conference is also mentioned' do
        let(:non_conference_mention) do
          double(:user_mention, screen_name: 'jack', id: 12)
        end
        let(:user_mentions) { [conference_mention, non_conference_mention] }

        it 'returns a single tweet' do
          expect(Tweet.from_twitter(tweet).size).to eq(1)
        end

        it 'creates a tweet assigned to the conference' do
          expect(Tweet.from_twitter(tweet).first.attributes).to include(
            'conference_id' => conference.id,
          )
        end
      end

      context 'when another conference is mentioned' do
        let!(:other_conference) { Conference.create!(twitter_handle: 'railsconf') }
        let(:other_conference_mention) do
          double(:user_mention, screen_name: other_conference.twitter_handle, id: 5493662)
        end
        let(:user_mentions) { [conference_mention, other_conference_mention] }

        it 'returns two tweets' do
          expect(Tweet.from_twitter(tweet).size).to eq(2)
        end

        it 'returns a tweet for the first conference' do
          expect(Tweet.from_twitter(tweet).first.attributes).to include(
            'conference_id' => conference.id,
          )
        end

        it 'returns a tweet for the second conference' do
          expect(Tweet.from_twitter(tweet).last.attributes).to include(
            'conference_id' => other_conference.id,
          )
        end
      end
    end

    context 'when no users are mentioned' do
      let(:user_mentions) { [] }

      it 'does not return any tweets' do
        expect(Tweet.from_twitter(tweet).size).to eq(0)
      end
    end
  end
end
