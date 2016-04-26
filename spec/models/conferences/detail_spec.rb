require 'rails_helper'

RSpec.describe Conference::Detail do
  let(:conference) do
    Conference.create!(
      twitter_handle: 'hamconf',
      location: 'San Dimas, CA',
      starts_at: Date.today - 1.year,
      ends_at: Date.today - 1.year,
      uid: '1',
    )
  end
  let(:attributes) { {conference: conference} }

  subject(:details) { Conference::Detail.new(attributes) }

  it { is_expected.to be_persisted }
  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_presence_of(:starts_at) }
  it { is_expected.to validate_presence_of(:ends_at) }

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
      let(:attributes) do
        {
          conference: conference,
          location: 'hamville',
          starts_at: Date.today - 1.day,
          ends_at: Date.today,
          attendee_count: 132
        }
      end

      it 'returns true' do
        expect(details.save).to eq(true)
      end

      it 'updates the conference location' do
        expect { details.save }.
          to change { conference.reload.location }.
          to('hamville')
      end

      it 'updates the conference start date' do
        expect { details.save }.
          to change { conference.reload.starts_at }.
          to(Date.today - 1.day)
      end

      it 'updates the conference end date' do
        expect { details.save }.
          to change { conference.reload.ends_at }.
          to(Date.today)
      end

      it 'updates the conference attendee count' do
        expect { details.save }.
          to change { conference.reload.attendee_count }.
          to(132)
      end
    end
  end
end
