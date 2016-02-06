require 'rails_helper'

RSpec.describe ConferencesController do
  let(:twitter_handle) { "foobar" }

  describe "GET #show" do
    let!(:conference) do
      Conference.create(twitter_handle: twitter_handle, approved_at: approved_at)
    end
    let(:approved_at) { Time.now }

    context "when requested conference is approved" do
      specify do
        get :show, id: twitter_handle
        expect(response).to be_success
      end

      it "assigns the conference" do
        get :show, id: twitter_handle
        expect(assigns(:conference).instance).to eq(conference)
      end
    end

    context "when the conference is not approved" do
      let(:approved_at) { nil }

      it "redirects to the home page" do
        expect { get :show, id: twitter_handle }.
          to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "when the requested conference doesn't exist" do
      it "raises a not found exception" do
        expect { get :show, id: "fake_twitter_handle" }.
          to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #edit" do
    let!(:conference) do
      Conference.create(twitter_handle: twitter_handle)
    end
    let(:organizer) do
      ConferenceOrganizer.create(uid: '123', provider: 'twitter', conference: conference)
    end

    context 'when not signed in' do
      it 'boots the browser back to the root path' do
        get :edit, id: twitter_handle
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the appropriate organizer is signed in' do
      before { sign_in :conference_organizer, organizer }

      it "assigns the conference" do
        get :edit, id: twitter_handle
        expect(assigns(:conference)).to eq(conference)
      end
    end

    context 'when a different organizer is signed in' do
      before do
        Conference.create(twitter_handle: "not_my_twitter_handle")
        sign_in :conference_organizer, organizer
      end

      it "raises a not authorized error" do
        expect { get :edit, id: "not_my_twitter_handle" }.
          to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe "GET #index" do
    let!(:conference) do
      Conference.create(twitter_handle: twitter_handle, approved_at: Time.now)
    end

    let!(:unapproved_conference) do
      Conference.create(twitter_handle: 'grumpyconf', approved_at: nil)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns all the approved conferences" do
      get :index
      expect(assigns(:conferences)).to eq([conference])
    end
  end
end
