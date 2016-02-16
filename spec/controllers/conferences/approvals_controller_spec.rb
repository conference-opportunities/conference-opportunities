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

      def make_request(conference = {name: "hamconf"})
        post :create, conference_id: "myconf", conference: conference
      end

      it "redirects to the conference" do
        make_request
        expect(response).to redirect_to(conference)
      end

      it "approves the conference" do
        expect { make_request }.
        to change { conference.reload.approved_at }.from(nil)
      end

      it "updates passed in attributes" do
        expect { make_request(name: "Most excellent conf") }.
        to change { conference.reload.name }.to("Most excellent conf")
      end
    end
  end
end
