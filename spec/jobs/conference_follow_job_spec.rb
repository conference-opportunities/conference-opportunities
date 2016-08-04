require 'rails_helper'

RSpec.describe ConferenceFollowJob, type: :job do
  let(:client) { Twitter::REST::Client.new }
  let(:fake_credentials) { double(:credentials, client: client) }
  let(:fake_user) { Twitter::User.new(id: 3237999706, screen_name: 'andconf') }

  subject(:job) { ConferenceFollowJob.new }

  before do
    allow(client).to receive(:user).and_return(fake_user)
    allow(TwitterCredentials).to receive(:create).and_return(fake_credentials)
  end

  describe '#perform' do
    context 'when the conference does not exist' do
      it 'makes a new conference' do
        expect { job.perform(3237999706) }.to change(Conference, :count).by(1)
      end

      it 'sets information from twitter' do
        job.perform(3237999706)
        expect(Conference.last.twitter_handle).to eq('andconf')
      end
    end

    context 'when the conference exists and is currently followed' do
      let!(:conference) { FactoryGirl.create(:conference, uid: 3237999706) }

      it 'does not create a new conference' do
        expect { job.perform(3237999706) }.not_to change(Conference, :count)
      end

      it 'does not change the unfollowed time' do
        expect { job.perform(3237999706) }.not_to change{ conference.reload.unfollowed_at }
      end
    end

    context 'when the conference exists and is currently unfollowed' do
      let!(:conference) { FactoryGirl.create(:conference, :unfollowed, uid: 3237999706) }

      it 'does not create a new conference' do
        expect { job.perform(3237999706) }.not_to change(Conference, :count)
      end

      it 'removes the unfollowed time stamp' do
        expect { job.perform(3237999706) }.to change{ conference.reload.unfollowed_at }.to(nil)
      end
    end
  end
end
