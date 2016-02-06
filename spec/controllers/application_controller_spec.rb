require "rails_helper"

RSpec.describe ApplicationController do
  let(:scope) { double(:scope) }

  describe "#new_session_path" do
    it "returns root path" do
      expect(controller.new_session_path(scope)).to eq root_path
    end
  end
end
