require 'rails_helper'

RSpec.describe ConferenceBatchJob, type: :job do
  let(:client) { Twitter::REST::Client.new }
  let(:fake_credentials) { double(:credentials, client: client) }
  let(:friends) { [] }

  subject(:job) { ConferenceBatchJob.new }

  before do
    allow(client).to receive(:friend_ids).and_return(friends)
    allow(TwitterCredentials).to receive(:create).and_return(fake_credentials)
  end

  describe '#perform' do
    context 'when the account does not follow any conferences' do
      context 'when the account still does not follow any conferences' do
        let(:friends) { [] }

        it 'does not update any conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUpdateJob)
        end

        it 'does not notice any newly-followed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceFollowJob)
        end

        it 'does not notice any newly-unfollowed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUnfollowJob)
        end
      end

      context 'when the account has just followed a conference' do
        let(:friends) { [3237999706] }

        it 'does not update any conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUpdateJob)
        end

        it 'notices a newly-followed conference' do
          expect { job.perform }.to enqueue_job(ConferenceFollowJob).with(3237999706)
        end

        it 'does not notice any newly-unfollowed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUnfollowJob)
        end
      end
    end

    context 'when the account follows a conference' do
      before { Conference.create!(twitter_handle: 'andconf', uid: 3237999706) }

      context 'when the account still only follows that conference' do
        let(:friends) { [3237999706] }

        it 'does not update any conferences' do
          expect { job.perform }.to enqueue_job(ConferenceUpdateJob).with([3237999706])
        end

        it 'does not notice any newly-followed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceFollowJob)
        end

        it 'does not notice any newly-unfollowed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUnfollowJob)
        end
      end

      context 'when the account has just followed another conference' do
        let(:friends) { [3237999706, 708110203464474600] }

        it 'does not update any conferences' do
          expect { job.perform }.to enqueue_job(ConferenceUpdateJob).with([3237999706])
        end

        it 'notices a newly-followed conference' do
          expect { job.perform }.to enqueue_job(ConferenceFollowJob).with(708110203464474600)
        end

        it 'does not notice any newly-unfollowed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUnfollowJob)
        end
      end

      context 'when the account has just unfollowed that conference' do
        let(:friends) { [] }

        it 'does not update any conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceUpdateJob)
        end

        it 'does not notice any newly-followed conferences' do
          expect { job.perform }.not_to enqueue_job(ConferenceFollowJob)
        end

        it 'notices a newly-unfollowed conference' do
          expect { job.perform }.to enqueue_job(ConferenceUnfollowJob).with(3237999706)
        end
      end
    end
  end
end
