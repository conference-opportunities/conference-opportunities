require "rails_helper"

RSpec.describe ConferencePolicy do
  let(:conference) { Conference.create(twitter_handle: "handleconf", uid: "666") }
  let(:organizer) { Organizer.create(conference: conference) }

  subject(:policy) { ConferencePolicy.new(organizer, conference) }

  describe "#edit?" do
    context "when the conference organizer owns the conference" do
      it { is_expected.to be_edit }
    end

    context "when the conference organizer does NOT own the conference" do
      let(:organizer) { Organizer.create }

      it { is_expected.not_to be_edit }
    end
  end

  describe "#show?" do
    context "when the conference is not approved" do
      it { is_expected.not_to be_show }
    end

    context "when the conference is approved" do
      let(:conference) { Conference.create(twitter_handle: "handleconf", approved_at: Date.today, uid: "667") }
      it { is_expected.to be_show }
    end
  end

  describe ConferencePolicy::Scope do
    let!(:approved_conference) do
      Conference.create(twitter_handle: 'happycon', approved_at: Time.now, uid: "668")
    end

    let!(:unapproved_conference) do
      Conference.create(twitter_handle: 'grumpycon', approved_at: nil, uid: "669")
    end

    describe "#resolve" do
      subject(:conferences) do
        ConferencePolicy::Scope.new(organizer, Conference).resolve
      end

      it { is_expected.to include(approved_conference) }
      it { is_expected.not_to include(unapproved_conference) }
    end
  end
end
