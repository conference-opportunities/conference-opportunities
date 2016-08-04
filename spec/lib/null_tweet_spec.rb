require 'rails_helper'

RSpec.describe NullTweet do
  describe '#twitter_id' do
    it 'returns 1' do
      expect(subject.twitter_id).to eq(1)
    end
  end
end
