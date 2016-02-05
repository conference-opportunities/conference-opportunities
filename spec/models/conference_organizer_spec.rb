require 'rails_helper'

RSpec.describe ConferenceOrganizer do
  subject(:organizer) do
    ConferenceOrganizer.new(provider: 'diogenes', uid: '1',
                            conference: conference)
  end

  let!(:conference) do
    Conference.create!(twitter_handle: 'confconf')
  end

  specify { expect(subject).to belong_to(:conference) }
  specify { expect(subject).to validate_presence_of(:conference_id) }
  specify { expect(subject).to validate_uniqueness_of(:conference_id) }

  specify { expect(subject).to validate_presence_of(:provider) }
  specify { expect(subject).to validate_presence_of(:uid) }
  specify { expect(subject).to validate_uniqueness_of(:uid).scoped_to(:provider) }

  describe ".from_omniauth" do
    let(:info) { OpenStruct.new(nickname: 'confconf') }
    let(:auth) { OpenStruct.new(provider: 'diogenes', uid: '1', info: info) }

    context "when the conference organizer already exist" do
      before { organizer.save! }

      it "returns the existing conference organizer" do
        expect(ConferenceOrganizer.from_omniauth(auth)).to eq(organizer)
      end
    end

    context "when the conference organizer does NOT already exist" do
      let(:new_organizer) { ConferenceOrganizer.from_omniauth(auth) }

      context "when there is a corresponding conference" do
        it "initializes a valid organizer for the conference" do
          expect(new_organizer).to be_valid
          expect(new_organizer.conference).to eq(conference)
        end
      end

      context "when there is NOT a corresponding conference" do
        let(:info) { OpenStruct.new(nickname: 'notaconf') }

        it "returns an invalid organizer" do
          expect(new_organizer).not_to be_valid
        end
      end
    end
  end
end
