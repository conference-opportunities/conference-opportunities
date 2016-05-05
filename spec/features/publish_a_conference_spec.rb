require "rails_helper"

RSpec.feature "Publish a conference", :js do
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
    visit root_path(locale: :en)
    expect(page).not_to have_content "Interesting conference"

    visit approval_path(locale: :en)
    click_on "Yes, list me!"

    expect(find_field("Conference name").value).to eq "Interesting conference"

    fill_in "Conference name", with: "Six hours of bathroom lines"
    fill_in "Website", with: "http://www.example.com/bathroom-lines"

    click_on "Create listing"
    expect(page).to have_content "Tell speakers the basics"

    find("#conference_detail_location").click
    fill_in "Location", with: "Moscone Center"
    within '.pac-container' do
      find(".pac-item:first-child").click
    end
    expect(find("#conference_detail_location").value).to include('Moscone Center, San Francisco, CA')

    fill_in "conference_detail_starts_at", with: "01/01/2016"
    fill_in "conference_detail_ends_at", with: "01/01/2016"
    fill_in "Number of Attendees", with: "2"

    click_on "Next"

    expect(page).to have_content "Help speakers understand your event"

    find('label[for="conference_structure_track_count_1"]').click
    find('label[for="conference_structure_plenary"]').click
    find('label[for="conference_structure_tutorial"]').click
    find('label[for="conference_structure_workshop"]').click

    fill_in "Plenary", with: "3"
    fill_in "Tutorial", with: "10"
    fill_in "Workshop", with: "5"
    fill_in "How many are open for CFP submissions?", with: "15"

    fill_in "Number of submissions received", with: "30"

    click_on "Next"

    expect(page).to have_content "@conferencename"

    logout(:organizer)

    visit root_path(locale: :en)
    click_on "Six hours of bathroom lines"
    expect(current_path).to eq conference_path(conference)
  end
end
