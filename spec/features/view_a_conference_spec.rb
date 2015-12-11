require "rails_helper"

RSpec.feature "Conferences" do
  let!(:conference) do
    Conference.create!(
      name: "Interesing conference",
      twitter_handle: "interestconf",
      description: "About interesting things",
    )
  end

  scenario "Speaker views a conference" do
    visit root_path
    click_on conference.name
    expect(page).to have_content conference.description
  end
end
