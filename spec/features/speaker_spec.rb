require 'rails_helper'

RSpec.feature 'Speaker', type: :feature do
  before do
    FactoryGirl.create(:conference, :approved, name: 'InterestingConf', description: 'zzz')
  end

  scenario 'views a conference' do
    visit root_path
    click_on 'InterestingConf'
    expect(page).to have_content('zzz')
  end
end
