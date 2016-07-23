require 'rails_helper'

RSpec.describe ConferenceUnfollowJob, type: :job do
  subject(:job) { ConferenceUnfollowJob.new }

  describe '#perform' do
    context 'when the conference does not exist' do
      it 'blows up' do
        expect { job.perform(-1) }.to raise_error(ActiveRecord::RecordNotFound )
      end
    end

    context 'when the conference does exist' do
      let(:conference) { Conference.create!(uid: 1, twitter_handle: 'jam') }

      it 'sets the unfollowed time' do
        expect { job.perform(1) }.to change { conference.reload.unfollowed_at }.from(nil)
      end
    end
  end
end
