require 'rails_helper'

RSpec.feature 'Administrator', type: :feature do
  let(:organizer_uid) { '123' }
  let(:admin_uid) { 'abc' }
  let(:organizer) do
    Organizer.create!(provider: 'twitter', uid: organizer_uid, conference: conference)
  end

  let(:conference) do
    Conference.create!(twitter_handle: 'more_conferences_plz', uid: organizer_uid)
  end

  let(:valid_twitter_auth) do
    OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: organizer_uid,
      info: {nickname: 'more_conferences_plz'}
    )
  end

  before do
    OmniAuth.config.mock_auth[:twitter] = valid_twitter_auth
    allow(Rails.application.config).to receive(:application_twitter_id).and_return(admin_uid)
  end

  context 'when not logged in as an organizer' do
    scenario 'cannot view the rails admin dashboard' do
      visit rails_admin.dashboard_path
      expect(current_path).not_to eq(rails_admin.dashboard_path)
    end
  end

  context 'when logged in as an organizer' do
    let(:organizer_uid) { admin_uid }

    before { login_as(organizer, scope: :organizer) }

    scenario 'can view the rails admin dashboard' do
      visit rails_admin.dashboard_path
      expect(current_path).to eq(rails_admin.dashboard_path)
    end
  end
end
