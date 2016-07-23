require 'rails_helper'

RSpec.describe ConferenceUpdateJob, type: :job do
  let(:client) { Twitter::REST::Client.new }
  let(:fake_credentials) { double(:credentials, client: client) }
  let(:fake_user) { Twitter::User.new(id: 3237999706, screen_name: 'andconf') }

  subject(:job) { ConferenceUpdateJob.new }

  before do
    allow(client).to receive(:users).and_return([fake_user])
    allow(TwitterCredentials).to receive(:create).and_return(fake_credentials)
  end

  describe '#perform' do
    context 'when the conference does not exist' do
      it 'blows up' do
        expect { job.perform([-1]) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the conference exists' do
      let!(:conference) { Conference.create!(twitter_handle: '&:conf', uid: 3237999706) }

      it 'updates the name' do
        expect {
          job.perform([3237999706])
        }.to change { conference.reload.twitter_handle }.to('andconf')
      end
    end
  end
end
