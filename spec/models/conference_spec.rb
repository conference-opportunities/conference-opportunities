require 'rails_helper'

RSpec.describe Conference, type: :model do
  subject(:conference) do
    FactoryGirl.create(:conference, twitter_handle: 'pretzel', uid: '321')
  end

  it { is_expected.to have_one(:event).dependent(:destroy).inverse_of(:conference) }
  it { is_expected.to have_many(:tweets).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:twitter_handle) }
  it { is_expected.to validate_uniqueness_of(:twitter_handle).case_insensitive }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_uniqueness_of(:uid).case_insensitive }

  describe '.followed' do
    context 'when there are no conferences' do
      specify { expect(Conference.followed).to eq([]) }
    end

    context 'when there is a conference' do
      let(:unfollowed_at) { nil }
      let!(:conference) { FactoryGirl.create(:conference, unfollowed_at: unfollowed_at) }

      context 'when the conference has not been unfollowed' do
        let(:unfollowed_at) { nil }

        specify { expect(Conference.followed).to eq([conference]) }
      end

      context 'when the conference has been unfollowed' do
        let(:unfollowed_at) { Time.current }

        specify { expect(Conference.followed).to eq([]) }
      end
    end
  end

  describe '.approved' do
    context 'when there are no conferences' do
      specify { expect(Conference.approved).to eq([]) }
    end

    context 'when there is a conference' do
      let(:approved_at) { nil }
      let!(:conference) { FactoryGirl.create(:conference, approved_at: approved_at) }

      context 'when the conference has not been approved' do
        let(:approved_at) { nil }

        specify { expect(Conference.approved).to eq([]) }
      end

      context 'when the conference has been approved' do
        let(:approved_at) { Time.current }

        specify { expect(Conference.approved).to eq([conference]) }
      end
    end
  end

  describe '.from_twitter_user' do
    let(:user) do
      Twitter::User.new(
        id: '111',
        screen_name: 'twitterconf',
        name: 'Twitter Conf',
        profile_image_url_https: 'https://example.com/pugs.gif',
        profile_banner_url: 'https://example.com/pumpkin_field',
        location: 'Overpriced Urban Conclave',
        url: 'http://twitterconf.example.com',
        description: 'Ten hours of pitches',
      )
    end

    let(:conference) { Conference.from_twitter_user(user) }

    specify { expect(conference).to be_valid }
    specify { expect(conference.twitter_handle).to eq('twitterconf') }
    specify { expect(conference.name).to eq('Twitter Conf') }
    specify { expect(conference.logo_url).to eq('https://example.com/pugs.gif') }
    specify { expect(conference.banner_url).to eq('https://example.com/pumpkin_field/web_retina') }
    specify { expect(conference.location).to eq('Overpriced Urban Conclave') }
    specify { expect(conference.website_url).to eq('http://twitterconf.example.com') }
    specify { expect(conference.description).to eq('Ten hours of pitches') }

    context 'when a user already exists with the screen name' do
      let(:updated_user) do
        Twitter::User.new(
          id: '111',
          screen_name: 'twitterconf',
          name: 'Twitter Conf 2029',
          profile_image_url_https: 'https://example.com/cyber_pugs.gif',
          location: 'Nueva Overpriced Urban Conclave',
          url: 'http://twitterconf2029.example.com',
          description: 'Eleven hours of Ray Kurzweil on a large screen',
        )
      end

      before { conference.save! }

      it 'updates the modified fields' do
        expect { Conference.from_twitter_user(updated_user).save! }.
          to change { conference.reload.name }.
          from('Twitter Conf').
          to('Twitter Conf 2029')
      end
    end
  end

  describe '#update_from_twitter' do
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

    it 'assigns attributes from the twitter user' do
      expect(conference.update_from_twitter(user)).to eq(conference)
      expect(conference).to be_valid
      expect(conference.twitter_handle).to eq('twitterconf')
      expect(conference.name).to eq('Twitter Conf')
      expect(conference.logo_url).to eq('https://example.com/pugs.gif')
      expect(conference.location).to eq('Overpriced Urban Conclave')
      expect(conference.website_url).to eq('http://twitterconf.example.com')
      expect(conference.description).to eq('Ten hours of pitches')
    end
  end

  describe '#to_param' do
    it 'returns the twitter handle' do
      expect(conference.to_param).to eq('pretzel')
    end
  end
end
