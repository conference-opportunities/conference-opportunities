require "rails_helper"

RSpec.describe Conference::StructurePolicy do
  let(:conference) { Conference.create!(twitter_handle: "handleconf", uid: "666") }
  let(:organizer) { Organizer.create!(conference: conference, provider: "t", uid: "666") }
  let(:conference_structure) { Conference::Structure.new(conference: conference) }

  subject(:policy) { Conference::StructurePolicy.new(organizer, conference_structure) }

  describe "#update?" do
    context "when the conference organizer owns the conference" do
      it { is_expected.to be_update }
    end

    context "when the conference organizer does NOT own the conference" do
      let(:other_conference) { Conference.create!(twitter_handle: "thingconf", uid: "777") }
      let(:organizer) { Organizer.create!(conference: other_conference, provider: "t", uid: "777") }

      it { is_expected.not_to be_update }
    end
  end
end
