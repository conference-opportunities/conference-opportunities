require 'rails_helper'

RSpec.feature 'Spanish-speaking Organizer', type: :feature do
  let(:uid) { '123545' }
  let!(:conference) { FactoryGirl.create(:conference, uid: uid) }
  let(:valid_twitter_auth) do
    OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: uid,
      info: {nickname: 'conferencename'}
    )
  end

  before { OmniAuth.config.mock_auth[:twitter] = valid_twitter_auth }

  scenario 'approves a conference', :js do
    visit approval_path(locale: :es)
    click_on I18n.t('approvals.show.yes_list_me', locale: :es)
  end
end
