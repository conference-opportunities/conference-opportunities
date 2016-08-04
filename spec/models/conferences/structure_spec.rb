require 'rails_helper'

RSpec.describe Conference::Structure do
  let(:conference) { FactoryGirl.create(:conference, twitter_handle: 'hamconf') }
  let(:attributes) { {conference: conference} }

  subject(:structure) { Conference::Structure.new(attributes) }

  it { is_expected.to be_persisted }
  it { is_expected.to validate_numericality_of(:track_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:plenary_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:tutorial_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:workshop_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:keynote_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:talk_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:other_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:cfp_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:prior_submissions_count).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:panel_count).is_greater_than_or_equal_to(0).allow_nil }

  describe '#id' do
    it 'returns the twitter handle of the conference' do
      expect(structure.id).to eq('hamconf')
    end
  end

  describe '#save' do
    context 'when the detail is invalid' do
      let(:attributes) do
        {
          conference: conference,
          track_count: -1
        }
      end

      it 'returns false' do
        expect(structure.save).to eq(false)
      end
    end

    context 'when the detail is valid' do
      let(:attributes) do
        {
          conference: conference,
          track_count: 1
        }
      end

      it 'returns true' do
        expect(structure.save).to eq(true)
      end

      it 'updates the track count' do
        expect { structure.save }.
          to change { conference.reload.track_count }.
          to(1)
      end
    end
  end
end
