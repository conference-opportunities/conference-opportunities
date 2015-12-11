require 'rails_helper'

describe ConferencesController, type: :controller do
  describe "GET #show" do
    let(:twitter_handle) { "foobar" }

    context "when twitter_handle is known" do
      let!(:conference) do
        Conference.create(twitter_handle: twitter_handle)
      end

      specify do
        get :show, id: twitter_handle
        expect(response).to be_success
      end

      it "assigns the conference" do
        get :show, id: twitter_handle
        expect(assigns(:conference).twitter_name).to eq("@foobar")
      end
    end

    context "when twitter_handle is unknown" do
      it "assigns the conference" do
        get :show, id: twitter_handle
        expect(response).to have_http_status(404)
      end
    end
  end
end
