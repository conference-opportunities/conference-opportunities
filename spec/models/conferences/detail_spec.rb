require 'rails_helper'

RSpec.describe Conference::Detail, type: :model do
  let(:conference) { FactoryGirl.create(:conference, twitter_handle: 'hamconf') }
  let!(:event) { FactoryGirl.create(:event, conference: conference) }
  let(:attributes) { {conference: conference} }

  subject(:details) { Conference::Detail.new(attributes) }

  it { is_expected.to be_persisted }
  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_numericality_of(:attendee_count).allow_nil }
  it { is_expected.to allow_value('1981/12/30').for(:starts_at) }

  context 'when the start date is set' do
    let(:attributes) { {starts_at: '1981/12/30'} }
    it { is_expected.to allow_value('1982/12/30').for(:ends_at) }
  end

  describe '#id' do
    it 'returns the twitter handle of the conference' do
      expect(details.id).to eq('hamconf')
    end
  end

  describe '#save' do
    context 'when the detail is invalid' do
      it 'returns false' do
        expect(details.save).to eq(false)
      end
    end

    context 'when the detail is valid' do
      let(:start_time) { Date.today - 1.day }
      let(:end_time) { Date.today + 1.day }
      let(:attributes) do
        {
          conference: conference,
          location: 'hamville',
          starts_at: start_time,
          ends_at: end_time,
          attendee_count: 132
        }
      end

      it 'returns true' do
        expect(details.save).to eq(true)
      end

      context 'when there is no event' do
        let!(:event) { nil }

        it 'creates an event' do
          expect { details.save }.to change(Event, :count).by(1)
        end
      end

      it 'updates the conference location' do
        expect { details.save }.to change { event.reload.address }.to('hamville')
      end

      it 'updates the conference start date' do
        expect { details.save }.to change { event.reload.starts_at }.to(start_time)
      end

      it 'updates the conference end date' do
        expect { details.save }.to change { event.reload.ends_at }.to(end_time)
      end

      it 'updates the cfp end date' do
        expect { details.save }.to change { event.reload.call_for_proposals_ends_at }.to(start_time)
      end

      it 'updates the conference attendee count' do
        expect { details.save }.to change { event.reload.attendees_count }.to(132)
      end
    end
  end
end
