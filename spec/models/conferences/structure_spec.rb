require 'rails_helper'

RSpec.describe Conference::Structure, type: :model do
  let(:conference) { FactoryGirl.create(:conference, twitter_handle: 'hamconf', website_url: 'http://example.com/tickets') }
  let!(:event) { FactoryGirl.create(:event, conference: conference) }
  let(:attributes) { {conference: conference} }

  subject(:structure) { Conference::Structure.new(attributes) }

  it { is_expected.to be_persisted }

  it { is_expected.to validate_presence_of(:cfp_url) }
  it { is_expected.to validate_presence_of(:code_of_conduct_url) }
  it { is_expected.to validate_presence_of(:hashtag) }
  it { is_expected.to validate_presence_of(:has_childcare) }
  it { is_expected.to validate_presence_of(:has_diversity_scholarships) }
  it { is_expected.to validate_presence_of(:has_honorariums) }
  it { is_expected.to validate_presence_of(:has_lodging_funding) }
  it { is_expected.to validate_presence_of(:has_travel_funding) }

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

  it { is_expected.to allow_value('').for(:track_count) }
  it { is_expected.to allow_value('').for(:plenary_count) }
  it { is_expected.to allow_value('').for(:tutorial_count) }
  it { is_expected.to allow_value('').for(:workshop_count) }
  it { is_expected.to allow_value('').for(:keynote_count) }
  it { is_expected.to allow_value('').for(:talk_count) }
  it { is_expected.to allow_value('').for(:other_count) }
  it { is_expected.to allow_value('').for(:cfp_count) }
  it { is_expected.to allow_value('').for(:prior_submissions_count) }
  it { is_expected.to allow_value('').for(:panel_count) }

  describe '#id' do
    it 'returns the twitter handle of the conference' do
      expect(structure.id).to eq('hamconf')
    end
  end

  describe '#default_hashtag' do
    context 'when the event does not have a hashtag' do
      it 'returns the twitter handle of the conference' do
        expect(structure.default_hashtag).to eq('hamconf')
      end
    end

    context 'when the event has a hashtag' do
      let!(:event) { FactoryGirl.create(:event, conference: conference, hashtag: 'hashtagparty') }

      it 'returns the hashtag' do
        expect(structure.default_hashtag).to eq('hashtagparty')
      end
    end
  end

  describe '#default_call_for_proposals_url' do
    context 'when the event does not have a hashtag' do
      it 'returns the twitter handle of the conference' do
        expect(structure.default_call_for_proposals_url).to eq('http://example.com/tickets')
      end
    end

    context 'when the event has a call for proposals url' do
      let!(:event) { FactoryGirl.create(:event, conference: conference, call_for_proposals_url: 'http://example.com/cfp') }

      it 'returns the call for proposals url' do
        expect(structure.default_call_for_proposals_url).to eq('http://example.com/cfp')
      end
    end
  end

  describe '#default_code_of_conduct_url' do
    context 'when the event does not have a hashtag' do
      it 'returns the twitter handle of the conference' do
        expect(structure.default_code_of_conduct_url).to eq('http://example.com/tickets')
      end
    end

    context 'when the event has a code of conduct url' do
      let!(:event) { FactoryGirl.create(:event, conference: conference, code_of_conduct_url: 'http://example.com/conduct') }

      it 'returns the code of conduct url' do
        expect(structure.default_code_of_conduct_url).to eq('http://example.com/conduct')
      end
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
          track_count: 1,
          has_childcare: 'true',
          has_diversity_scholarships: 'true',
          has_honorariums: 'true',
          has_lodging_funding: 'true',
          has_travel_funding: 'true',
          cfp_url: 'https://example.com/cfp',
          code_of_conduct_url: 'https://example.com/code_of_conduct',
          hashtag: 'hashtagconf',
        }
      end

      it 'returns true' do
        expect(structure.save).to eq(true)
      end

      it 'updates the track count' do
        expect { structure.save }.to change { event.reload.tracks_count }.to(1)
      end
    end
  end
end
