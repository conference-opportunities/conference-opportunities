require 'rails_helper'

RSpec.describe CreateTweetJob, type: :job do
  subject(:job) { CreateTweetJob.new }

  describe '#perform' do
    context 'when the mentioned conference does not exist' do
      it 'does not create a tweet' do
        expect { job.perform(1, [1]) }.not_to change(Tweet, :count)
      end
    end

    context 'when the mentioned conference exists' do
      let!(:conference) { FactoryGirl.create(:conference, uid: 321) }

      it 'creates a tweet on the conference' do
        expect { job.perform(123, [321]) }.to change { conference.reload.tweets.count }.by(1)
      end
    end

    context 'when only one mentioned conference exists' do
      let!(:conference) { FactoryGirl.create(:conference, uid: 321) }

      it 'creates a tweet on the conference' do
        expect { job.perform(123, [321, 100]) }.to change { conference.reload.tweets.count }.by(1)
      end
    end

    context 'when both mentioned conferences exist' do
      let!(:conference) { FactoryGirl.create(:conference, uid: 321) }
      let!(:other_conference) { FactoryGirl.create(:conference, uid: 101) }

      it 'creates a tweet on the conference' do
        expect { job.perform(123, [321, 101]) }.to change { conference.reload.tweets.count }.by(1)
      end

      it 'creates a tweet on the other conference' do
        expect { job.perform(123, [321, 101]) }.to change { other_conference.reload.tweets.count }.by(1)
      end
    end

    context 'when the mentioned conference has already recorded the tweet' do
      let!(:conference) { FactoryGirl.create(:conference, uid: 456) }

      before { FactoryGirl.create(:tweet, twitter_id: 654, conference: conference) }

      it 'does not create another tweet on the conference' do
        expect { job.perform(654, [456]) }.not_to change { conference.reload.tweets.count }.from(1)
      end
    end
  end
end
