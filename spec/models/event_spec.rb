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
end
