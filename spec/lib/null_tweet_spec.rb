require 'rails_helper'

RSpec.describe NullTweet do
  describe '#twitter_id' do
    it 'returns 0' do
      expect(subject.twitter_id).to eq('0')
    end
  end
end
