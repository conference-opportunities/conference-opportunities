require 'rails_helper'

RSpec.describe ConferencePresenter do
  let(:conference) { FactoryGirl.create(:conference, twitter_handle: 'nameconf') }
  let!(:tweet) { FactoryGirl.create(:tweet, conference: conference) }

  subject(:presenter) { ConferencePresenter.new(conference) }

  it { is_expected.to delegate_method(:event).to(:conference).with_prefix(true) }

  it { is_expected.to delegate_method(:tweets).to(:conference) }
  it { is_expected.to delegate_method(:name).to(:conference) }
  it { is_expected.to delegate_method(:logo_url).to(:conference) }
  it { is_expected.to delegate_method(:banner_url).to(:conference) }
  it { is_expected.to delegate_method(:location).to(:conference) }
  it { is_expected.to delegate_method(:website_url).to(:conference) }
  it { is_expected.to delegate_method(:description).to(:conference) }

  it { is_expected.to delegate_method(:starts_at).to(:conference_event) }
  it { is_expected.to delegate_method(:ends_at).to(:conference_event) }
  it { is_expected.to delegate_method(:call_for_proposals_ends_at).to(:conference_event) }
  it { is_expected.to delegate_method(:speaker_notifications_at).to(:conference_event) }
  it { is_expected.to delegate_method(:call_for_proposals_url).to(:conference_event) }
  it { is_expected.to delegate_method(:code_of_conduct_url).to(:conference_event) }
  it { is_expected.to delegate_method(:has_childcare).to(:conference_event) }
  it { is_expected.to delegate_method(:has_diversity_scholarships).to(:conference_event) }
  it { is_expected.to delegate_method(:has_honorariums).to(:conference_event) }
  it { is_expected.to delegate_method(:has_lodging_funding).to(:conference_event) }
  it { is_expected.to delegate_method(:has_travel_funding).to(:conference_event) }

  specify { expect(presenter.twitter_name).to eq('@nameconf') }
  specify { expect(presenter.twitter_url).to eq('https://twitter.com/nameconf') }

  context 'when there is an event' do
    let!(:event) { FactoryGirl.create(:event, :complete, conference: conference, hashtag: 'nameconf16') }

    specify { expect(presenter.hashtag).to eq('#nameconf16') }
  end

  context 'when there is no event' do
    let(:event) { nil }
    specify { expect(presenter.hashtag).to eq(nil) }
  end
end
