require "rails_helper"

RSpec.describe ConferencePolicy do
  let(:policy) { ConferencePolicy.new(organizer, conference) }

  describe "#edit?" do
    let(:conference) { Conference.create(twitter_handle: "handleconf") }

    context "when the conference organizer owns the conference" do
      let(:organizer) { ConferenceOrganizer.create(conference: conference) }

      specify { expect(policy).to be_edit }
    end

    context "when the conference organizer does NOT own the conference" do
      let(:organizer) { ConferenceOrganizer.create }

      specify { expect(policy).not_to be_edit }
    end
  end
end
