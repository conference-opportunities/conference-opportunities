require "rails_helper"

RSpec.describe Conferences::ApprovalsController do
  describe "POST #create" do
    let!(:conference) { Conference.create! twitter_handle: "myconf" }
    let(:organizer) do
      ConferenceOrganizer.create(uid: '123', provider: 'twitter',
                                 conference: conference)
    end

    context "organizer is not logged in" do
      it "redirects to the root path" do
        post :create, conference_id: "myconf"
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when a different organizer is signed in' do
      before do
        Conference.create(twitter_handle: "not_my_twitter_handle")
        sign_in :conference_organizer, organizer
      end

      it "raises a not authorized error" do
        expect { post :create, conference_id: "not_my_twitter_handle" }.
          to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "organizer is authorized" do
      before { sign_in :conference_organizer, organizer }

      it "redirects to the conference" do
        post :create, conference_id: "myconf"
        expect(response).to redirect_to(conference)
      end

      it "approves the conference" do
        expect { post :create, conference_id: "myconf" }.
        to change { conference.reload.approved_at }.from(nil)
      end
    end
  end
end
