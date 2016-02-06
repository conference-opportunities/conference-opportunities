require "rails_helper"

RSpec.feature "Publish a conference", :js do
  let!(:conference) do
    Conference.create!(
      name: "Interesting conference",
      twitter_handle: "conferencename",
      description: "All about how great oatmeal is, or something",
    )
  end
  let(:valid_twitter_auth) do
    OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '123545',
      info: {nickname: 'conferencename'}
    )
  end

  before do
    OmniAuth.config.mock_auth[:twitter] = valid_twitter_auth
  end

  scenario "a followed conference organizer can list their conference" do
    visit approval_path
    click_on "Yes, list me!"
    expect(page).to have_content "List your conference"
    click_on "Create listing"
    expect(page).to have_content "@conferencename"
  end
end
