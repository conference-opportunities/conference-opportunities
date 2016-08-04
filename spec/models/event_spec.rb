require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:conference).inverse_of(:event) }

  describe '#geocode' do
    let(:event) { FactoryGirl.build(:event, latitude: nil, longitude: nil) }

    it 'sets the coordinates' do
      expect(event.to_coordinates).to eq([nil, nil])
      event.valid?
      expect(event.to_coordinates).to eq([37.783333, -122.416667])
    end
  end

  describe '.followed' do
    context 'when there are no events' do
      specify { expect(Event.followed).to eq([]) }
    end

    context 'when there is an event' do
      let(:unfollowed_at) { nil }
      let(:conference) { FactoryGirl.create(:conference, unfollowed_at: unfollowed_at) }
      let!(:event) { FactoryGirl.create(:event, conference: conference) }

      context 'when the conference for the event has not been unfollowed' do
        let(:unfollowed_at) { nil }

        specify { expect(Event.followed).to eq([event]) }
      end

      context 'when the conference for the event has been unfollowed' do
        let(:unfollowed_at) { Time.current }

        specify { expect(Event.followed).to eq([]) }
      end
    end
  end

  describe '.approved' do
    context 'when there are no conferences' do
      specify { expect(Event.approved).to eq([]) }
    end

    context 'when there is a conference' do
      let(:approved_at) { nil }
      let(:conference) { FactoryGirl.create(:conference, approved_at: approved_at) }
      let!(:event) { FactoryGirl.create(:event, conference: conference) }

      context 'when the conference for the event has not been approved' do
        let(:approved_at) { nil }

        specify { expect(Event.approved).to eq([]) }
      end

      context 'when the conference for the event has been approved' do
        let(:approved_at) { Time.current }

        specify { expect(Event.approved).to eq([event]) }
      end
    end
  end
end
