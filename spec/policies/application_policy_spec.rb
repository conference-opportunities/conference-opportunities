require "rails_helper"

RSpec.describe ApplicationPolicy do
  let(:conference) { Conference.create!(twitter_handle: 'hamtasteconf', uid: 'taste') }
  let!(:organizer) { Organizer.create!(provider: 'ham', uid: 'taste', conference: conference) }

  subject(:policy) { ApplicationPolicy.new(organizer, organizer) }

  it { is_expected.not_to be_index }
  it { is_expected.not_to be_create }
  it { is_expected.not_to be_new }
  it { is_expected.not_to be_update }
  it { is_expected.not_to be_edit }
  it { is_expected.not_to be_destroy }

  describe '#dashboard?' do
    context 'when the UID is not the admin UID' do
      before { allow(Rails.application.config).to receive(:application_twitter_id).and_return('1') }
      it { is_expected.not_to be_dashboard }
    end

    context 'when the UID is the admin UID' do
      before { allow(Rails.application.config).to receive(:application_twitter_id).and_return('taste') }
      it { is_expected.to be_dashboard }
    end
  end

  describe "#show?" do
    context "when the record is not persisted" do
      let(:organizer) { Conference.new(id: 0, twitter_handle: "handleconf", approved_at: Date.today) }
      it { is_expected.not_to be_show }
    end

    context "when the record is persisted" do
      it { is_expected.to be_show }
    end
  end

  describe ApplicationPolicy::Scope do
    describe "#resolve" do
      subject(:conferences) do
        ApplicationPolicy::Scope.new(organizer, Organizer).resolve.all
      end

      it { is_expected.to eq([organizer]) }
    end
  end
end
