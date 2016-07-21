require "rails_helper"

RSpec.feature "Viewing a conference", type: :feature do
  let!(:conference) do
    Conference.create!(
      name: "Interesting conference",
      twitter_handle: "interestconf",
      description: "All about how great oatmeal is, or something",
      approved_at: Time.now,
      uid: "hay"
    )
  end

  scenario "displays the conference description" do
    visit root_path
    click_on conference.name
    expect(page).to have_content(conference.description)
  end
end
