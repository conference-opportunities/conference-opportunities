require 'rails_helper'

RSpec.describe TweetPolicy do
  let(:conference_uid) { '123' }
  let(:organizer_uid) { '987' }
  let(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }
  let(:tweet) { FactoryGirl.create(:tweet, conference: conference) }
  let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: organizer_uid) }

  subject(:policy) { TweetPolicy.new(user, tweet) }

  context 'when not logged in' do
    let(:user) { nil }

    context 'when the conference is approved and followed by the main account' do
      let(:conference) { FactoryGirl.create(:conference, :approved, uid: conference_uid) }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_action(:new) }
      it { is_expected.to forbid_action(:create) }
      it { is_expected.to forbid_action(:edit) }
      it { is_expected.to forbid_action(:update) }
      it { is_expected.to forbid_action(:destroy) }
    end

    context 'when the conference was approved but unfollowed by the main account' do
      let(:conference) { FactoryGirl.create(:conference, :approved, :unfollowed, uid: conference_uid) }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to forbid_action(:show) }
      it { is_expected.to forbid_action(:new) }
      it { is_expected.to forbid_action(:create) }
      it { is_expected.to forbid_action(:edit) }
      it { is_expected.to forbid_action(:update) }
      it { is_expected.to forbid_action(:destroy) }
    end

    context 'when the conference has not been approved by its organizer' do
      let(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to forbid_action(:show) }
      it { is_expected.to forbid_action(:new) }
      it { is_expected.to forbid_action(:create) }
      it { is_expected.to forbid_action(:edit) }
      it { is_expected.to forbid_action(:update) }
      it { is_expected.to forbid_action(:destroy) }
    end
  end

  context 'when logged in as the admin' do
    let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: '765') }

    before do
      allow(Rails.application.config).to receive(:application_twitter_id).and_return('765')
    end

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'when logged in as a regular organizer' do
    let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: organizer_uid) }

    context 'when the organizer owns the conference' do
      let(:conference_uid) { '123' }
      let(:organizer_uid) { '123' }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_action(:new) }
      it { is_expected.to forbid_action(:create) }
      it { is_expected.to permit_action(:edit) }
      it { is_expected.to permit_action(:update) }
      it { is_expected.to forbid_action(:destroy) }
    end

    context 'when the organizer does not own the conference' do
      let(:other_conference) { FactoryGirl.create(:conference, :approved, uid: '456') }
      let(:user) { FactoryGirl.create(:organizer, conference: other_conference, uid: organizer_uid) }
      let(:conference_uid) { '123' }
      let(:organizer_uid) { '987' }

      context 'when the conference is approved and followed by the main account' do
        let(:conference) { FactoryGirl.create(:conference, :approved, uid: conference_uid) }

        it { is_expected.to permit_action(:index) }
        it { is_expected.to permit_action(:show) }
        it { is_expected.to forbid_action(:new) }
        it { is_expected.to forbid_action(:create) }
        it { is_expected.to forbid_action(:edit) }
        it { is_expected.to forbid_action(:update) }
        it { is_expected.to forbid_action(:destroy) }
      end

      context 'when the conference was unfollowed by the main account' do
        let(:conference) { FactoryGirl.create(:conference, :unfollowed, uid: conference_uid) }

        it { is_expected.to permit_action(:index) }
        it { is_expected.to forbid_action(:show) }
        it { is_expected.to forbid_action(:new) }
        it { is_expected.to forbid_action(:create) }
        it { is_expected.to forbid_action(:edit) }
        it { is_expected.to forbid_action(:update) }
        it { is_expected.to forbid_action(:destroy) }
      end

      context 'when the conference has not been approved by its organizer' do
        let(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }

        it { is_expected.to permit_action(:index) }
        it { is_expected.to forbid_action(:show) }
        it { is_expected.to forbid_action(:new) }
        it { is_expected.to forbid_action(:create) }
        it { is_expected.to forbid_action(:edit) }
        it { is_expected.to forbid_action(:update) }
        it { is_expected.to forbid_action(:destroy) }
      end
    end
  end

  describe TweetPolicy::Scope do
    context 'when not logged in' do
      context 'when there are no conferences' do
        specify { expect(TweetPolicy::Scope.new(nil, Tweet).resolve).to eq([]) }
      end

      context 'when there are no events' do
        before { FactoryGirl.create(:conference, :approved) }

        specify { expect(TweetPolicy::Scope.new(nil, Tweet).resolve).to eq([]) }
      end

      context 'when there is a conference' do
        let!(:event) { FactoryGirl.create(:event, conference: conference) }

        context 'when the conference is not approved' do
          let!(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }

          specify { expect(TweetPolicy::Scope.new(nil, Tweet).resolve).to eq([]) }
        end

        context 'when the conference has been unfollowed' do
          let!(:conference) { FactoryGirl.create(:conference, :approved, :unfollowed, uid: conference_uid) }

          specify { expect(TweetPolicy::Scope.new(nil, Tweet).resolve).to eq([]) }
        end

        context 'when the conference is followed and approved'do
          let!(:conference) { FactoryGirl.create(:conference, :approved, uid: conference_uid) }

          specify { expect(TweetPolicy::Scope.new(nil, Tweet).resolve).to eq([tweet]) }
        end
      end
    end

    context 'when logged in as the admin' do
      let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: '765') }
      let!(:event) { FactoryGirl.create(:event, conference: conference) }

      before do
        allow(Rails.application.config).to receive(:application_twitter_id).and_return('765')
      end

      context 'when the conference is not approved' do
        let!(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([tweet]) }
      end

      context 'when the conference has been unfollowed' do
        let!(:conference) { FactoryGirl.create(:conference, :approved, :unfollowed, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([tweet]) }
      end

      context 'when the conference is followed and approved'do
        let!(:conference) { FactoryGirl.create(:conference, :approved, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([tweet]) }
      end
    end

    context 'when logged in as the organizer of the conference' do
      let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: conference_uid) }
      let!(:event) { FactoryGirl.create(:event, conference: conference) }

      context 'when the conference is not approved' do
        let!(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([]) }
      end

      context 'when the conference has been unfollowed' do
        let!(:conference) { FactoryGirl.create(:conference, :unfollowed, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([]) }
      end

      context 'when the conference is followed and approved' do
        let!(:conference) { FactoryGirl.create(:conference, :approved, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([tweet]) }
      end
    end

    context 'when logged in as the organizer of another conference' do
      let(:other_uid) { '412' }
      let(:other_conference) { FactoryGirl.create(:conference, uid: other_uid) }
      let!(:user) { FactoryGirl.create(:organizer, conference: other_conference, uid: other_uid) }
      let!(:event) { FactoryGirl.create(:event, conference: conference) }

      context 'when the conference is not approved' do
        let!(:conference) { FactoryGirl.create(:conference, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([]) }
      end

      context 'when the conference has been unfollowed' do
        let!(:conference) { FactoryGirl.create(:conference, :unfollowed, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([]) }
      end

      context 'when the conference is followed and approved' do
        let!(:conference) { FactoryGirl.create(:conference, :approved, uid: conference_uid) }

        specify { expect(TweetPolicy::Scope.new(user, Tweet).resolve).to eq([tweet]) }
      end
    end
  end
end
