require 'rails_helper'

RSpec.describe Organizer do
  subject(:organizer) do
    Organizer.new(provider: 'diogenes', uid: '1',
                            conference: conference)
  end

  let!(:conference) do
    Conference.create!(twitter_handle: 'confconf')
  end

  it { is_expected.to have_one(:organizer_conference) }
  it { is_expected.to have_one(:conference).through(:organizer_conference) }

  it { is_expected.to validate_presence_of(:organizer_conference) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }

  describe ".from_omniauth" do
    let(:info) { OpenStruct.new(nickname: 'confconf') }
    let(:auth) { OpenStruct.new(provider: 'diogenes', uid: '1', info: info) }

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
        let(:info) { OpenStruct.new(nickname: 'notaconf') }

        it "returns an invalid organizer" do
          expect(new_organizer).not_to be_valid
        end
      end
    end
  end
end
