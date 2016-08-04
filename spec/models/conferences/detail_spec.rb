require 'rails_helper'

RSpec.describe Conference::Detail do
  let(:conference) { FactoryGirl.create(:conference, twitter_handle: 'hamconf') }
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

  describe '#attendee_count=' do
    context 'with a number' do
      it 'returns that number' do
        details.attendee_count = 1
        expect(details.attendee_count).to eq(1)
      end
    end

    context 'with an empty string' do
      it 'returns nil' do
        details.attendee_count = ""
        expect(details.attendee_count).to eq(nil)
      end
    end

    context 'with nil' do
      it 'returns nil' do
        details.attendee_count = nil
        expect(details.attendee_count).to eq(nil)
      end
    end
  end

  describe '#starts_at=' do
    context 'with a date' do
      it 'returns that date' do
        details.starts_at = Date.today
        expect(details.starts_at).to eq(Date.today)
      end
    end

    context 'with a valid date string' do
      it 'returns that date' do
        details.starts_at = DateTime.now.to_formatted_s(:db)
        expect(details.starts_at).to eq(Date.today)
      end
    end

    context 'with an invalid date string' do
      it 'returns nil' do
        details.starts_at = 'cutlets'
        expect(details.starts_at).to eq(nil)
      end
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
