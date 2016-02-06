require 'rails_helper'

RSpec.describe Conference do
  subject(:conference) { Conference.create!(twitter_handle: 'bobdole') }

  specify { expect(subject).to have_many(:tweets).dependent(:destroy) }
  specify { expect(subject).to validate_presence_of(:twitter_handle) }
  specify { expect(subject).to validate_uniqueness_of(:twitter_handle) }

  describe ".from_twitter_user" do
    let(:user) do
      Twitter::User.new(
        id: '111',
        screen_name: 'twitterconf',
        name: 'Twitter Conf',
        profile_image_url_https: 'https://example.com/pugs.gif',
        location: 'Overpriced Urban Conclave',
        url: 'http://twitterconf.example.com',
        description: 'Ten hours of pitches',
      )
    end

    subject(:conference) { Conference.from_twitter_user(user) }

    specify { expect(conference).to be_valid }
    specify { expect(conference.twitter_handle).to eq('twitterconf') }
    specify { expect(conference.name).to eq('Twitter Conf') }
    specify { expect(conference.logo_url).to eq('https://example.com/pugs.gif') }
    specify { expect(conference.location).to eq('Overpriced Urban Conclave') }
    specify { expect(conference.website_url).to eq('http://twitterconf.example.com') }
    specify { expect(conference.description).to eq('Ten hours of pitches') }
  end

  describe "#to_param" do
    it "returns the twitter handle" do
      expect(conference.to_param).to eq("bobdole")
    end
  end
end
