require 'rails_helper'

RSpec.describe Organizer do
  let(:admin_uid) { '123admin' }
  let(:uid) { '456' }
  let!(:conference) { FactoryGirl.create(:conference, uid: uid) }

  subject(:organizer) { FactoryGirl.build(:organizer, uid: uid, conference: conference) }

  before do
    allow(Rails.application.config).to receive(:application_twitter_id).and_return(admin_uid)
  end

  it { is_expected.to have_one(:organizer_conference) }
  it { is_expected.to have_one(:conference).through(:organizer_conference) }

  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }

  it { is_expected.to delegate_method(:twitter_handle).to(:conference) }

  describe '#organizer_conference' do
    context 'when the organizer is an admin' do
      let(:uid) { admin_uid }

      it { is_expected.not_to validate_presence_of(:organizer_conference) }
    end

    context 'when the organizer is not an admin' do
      it { is_expected.to validate_presence_of(:organizer_conference) }
    end
  end

  describe ".from_omniauth" do
    let(:auth) { OpenStruct.new(provider: 'twitter', uid: uid) }

    context "when the conference organizer already exist" do
      before { organizer.save! }

      it "returns the existing conference organizer" do
        expect(Organizer.from_omniauth(auth)).to eq(organizer)
      end
    end

    context "when the conference organizer does NOT already exist" do
      let(:new_organizer) { Organizer.from_omniauth(auth) }

      context "when there is a corresponding conference" do
        it "initializes a valid organizer for the conference" do
          expect(new_organizer).to be_valid
          expect(new_organizer.conference).to eq(conference)
        end
      end

      context "when there is NOT a corresponding conference" do
        let(:auth) { OpenStruct.new(provider: 'twitter', uid: '425') }

        it "returns an invalid organizer" do
          expect(new_organizer).not_to be_valid
        end
      end
    end
  end

  describe '#admin?' do
    context "when the organizer has the same UID as the app's twitter account" do
      let(:uid) { admin_uid }

      it 'returns true' do
        expect(organizer.admin?).to eq(true)
      end
    end

    context "when the organizer does not have the same UID as the app's twitter account" do
      it 'returns false' do
        expect(organizer.admin?).to eq(false)
      end
    end
  end
end
