require "rails_helper"

RSpec.feature "Publish a conference (es_ES)", :js do
  let(:uid) { '123545' }
  let!(:conference) do
    Conference.create!(
      name: "Interesting conference",
      twitter_handle: "conferencename",
      logo_url: 'http://placekitten.com/200/200',
      uid: uid,
      description: "All about how great oatmeal is, or something",
    )
  end
  let(:valid_twitter_auth) do
    OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: uid,
      info: {nickname: 'conferencename'}
    )
  end

  before do
    OmniAuth.config.mock_auth[:twitter] = valid_twitter_auth
  end

  scenario "a followed conference organizer can list their conference", :chrome do
    visit approval_path(locale: :es)
    click_on I18n.t('approvals.show.yes_list_me', locale: :es)
  end
end
