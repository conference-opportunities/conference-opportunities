require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:scope) { double(:scope) }

  describe '#new_session_path' do
    it 'returns root path' do
      expect(controller.new_session_path(scope)).to eq root_path
    end
  end

  describe '#pundit_user' do
    let(:conference) { FactoryGirl.create(:conference) }
    let(:organizer) { FactoryGirl.create(:organizer, conference: conference) }

    before { sign_in(organizer, scope: :organizer) }

    it 'returns the current organizer' do
      expect(controller.pundit_user).to eq(organizer)
    end
  end
end
