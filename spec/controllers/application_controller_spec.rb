require "rails_helper"

RSpec.describe ApplicationController do
  let(:scope) { double(:scope) }

  describe "#new_session_path" do
    it "returns root path" do
      expect(controller.new_session_path(scope)).to eq root_path
    end
  end

  describe "#pundit_user" do
    let(:conference) { Conference.create!(twitter_handle: "punditconf", uid: '123') }
    let(:organizer) { Organizer.create!(uid: '123', provider: 'twitter', conference: conference) }

    before { sign_in organizer }

    it "returns the current organizer" do
      expect(controller.pundit_user).to eq(organizer)
    end
  end
end
