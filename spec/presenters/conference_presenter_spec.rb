require 'rails_helper'

RSpec.describe ConferencePresenter do
  let(:conference) do
    Conference.new(
      logo_url: 'http://example.com/logo.png',
      name: 'Nameconf',
      twitter_handle: 'nameconf',
      location: 'Dystopia',
      website_url: 'http://example.com',
      description: 'A conference on names.'
    )
  end
  let!(:tweet) { conference.tweets.new(twitter_id: 'ham') }

  subject(:presenter) { ConferencePresenter.new(conference) }

  specify { expect(presenter.logo_url).to eq('http://example.com/logo.png') }
  specify { expect(presenter.name).to eq('Nameconf') }
  specify { expect(presenter.website_url).to eq('http://example.com') }
  specify { expect(presenter.location).to eq('Dystopia') }
  specify { expect(presenter.description).to eq('A conference on names.') }
  specify { expect(presenter.twitter_name).to eq('@nameconf') }
  specify { expect(presenter.twitter_url).to eq('https://twitter.com/nameconf') }
  specify { expect(presenter.tweets).to eq([tweet]) }
end
