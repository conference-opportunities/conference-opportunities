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
    visit root_path
    expect(page).not_to have_content "Interesting conference"

    visit approval_path
    click_on "Yes, list me!"

    expect(find_field("Conference name").value).to eq "Interesting conference"

    fill_in "Conference name", with: "Six hours of bathroom lines"
    fill_in "Website", with: "http://www.example.com/bathroom-lines"

    click_on "Create listing"
    expect(page).to have_content "@conferencename"

    logout(:conference_organizer)

    visit root_path
    click_on "Six hours of bathroom lines"
    expect(current_path).to eq conference_path(conference)
  end
end
