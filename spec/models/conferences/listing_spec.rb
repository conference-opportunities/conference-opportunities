require 'rails_helper'

RSpec.describe Conference::Listing do
  let(:conference) { FactoryGirl.create(:conference, twitter_handle: 'hamconf') }
  let(:attributes) { {conference: conference} }

  subject(:listing) { Conference::Listing.new(attributes) }

  it { is_expected.not_to be_persisted }
  it { is_expected.to validate_presence_of(:name) }

  describe '#id' do
    it 'returns the twitter handle of the conference' do
      expect(listing.id).to eq('hamconf')
    end
  end

  describe '#save' do
    context 'when the detail is invalid' do
      it 'returns false' do
        expect(listing.save).to eq(false)
      end
    end

    context 'when the detail is valid' do
      let(:attributes) do
        {
          conference: conference,
          name: 'cheeseconf',
          logo_url: 'https://example.com/block_of_cheese.jpg',
          website_url: 'https://example.com/cheeseconf'
        }
      end

      it 'returns true' do
        expect(listing.save).to eq(true)
      end

      it 'updates the conference name' do
        expect { listing.save }.
          to change { conference.reload.name }.
          to('cheeseconf')
      end

      it 'updates the conference website url' do
        expect { listing.save }.
          to change { conference.reload.website_url }.
          to('https://example.com/cheeseconf')
      end

      it 'updates the conference logo url' do
        expect { listing.save }.
          to change { conference.reload.logo_url }.
          to('https://example.com/block_of_cheese.jpg')
      end

      it 'sets the approval time' do
        expect { listing.save }.
          to change { conference.reload.approved_at }.
          from(nil)
      end
    end
  end
end
