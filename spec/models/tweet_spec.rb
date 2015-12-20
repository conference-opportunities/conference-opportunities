require 'rails_helper'

RSpec.describe Tweet do
  let(:conference) { Conference.create!(twitter_handle: 'tweetconf') }
  subject(:tweet) { conference.tweets.build(twitter_id: 1) }

  it { is_expected.to belong_to(:conference) }
  it { is_expected.to validate_presence_of(:conference) }
end
