require "rails_helper"

RSpec.feature "Conferences", :vcr, :js do
  let!(:conference) do
    Conference.create!(
      name: "Interesting conference",
      twitter_handle: "interestconf",
      description: "All about how great oatmeal is, or something",
      approved_at: Time.now,
      uid: "hay"
    )
  end
  let(:actual_twitter_id) { '20' }
  before do
    conference.tweets.create!(twitter_id: actual_twitter_id)
  end

  scenario "Speaker views a conference", :chrome do
    visit root_path
    click_on conference.name
    expect(page).to have_content conference.description
    expect(page).to have_css '#twitter-widget-0'
    within_frame('twitter-widget-0') do
      expect(page).to have_content "just setting up my twttr"
    end
  end
end
