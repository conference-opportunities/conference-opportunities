require 'rails_helper'

RSpec.describe ConferencesController do
  let(:twitter_handle) { "foobar" }

  describe "GET #show" do
    let!(:conference) do
      Conference.create(twitter_handle: twitter_handle, approved_at: approved_at, uid: "666")
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
      Conference.create(twitter_handle: twitter_handle, uid: "123")
    end
    let(:organizer) do
      Organizer.create(uid: '123', provider: 'twitter', conference: conference)
    end

    context 'when not signed in' do
      it 'boots the browser back to the root path' do
        get :edit, id: twitter_handle
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the appropriate organizer is signed in' do
      before { sign_in :organizer, organizer }

      it "assigns the conference" do
        get :edit, id: twitter_handle
        expect(assigns(:conference)).to eq(conference)
      end
    end

    context 'when a different organizer is signed in' do
      before do
        Conference.create(twitter_handle: "not_my_twitter_handle", uid: "667")
        sign_in :organizer, organizer
      end

      it "raises a not authorized error" do
        expect { get :edit, id: "not_my_twitter_handle" }.
          to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe "PATCH #edit" do
    let!(:conference) { Conference.create! twitter_handle: "myconf", uid: "123" }
    let(:organizer) do
      Organizer.create(uid: '123', provider: 'twitter',
                                 conference: conference)
    end

    context "organizer is not logged in" do
      it "redirects to the root path" do
        patch :update, id: "myconf"
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when a different organizer is signed in' do
      before do
        Conference.create(twitter_handle: "not_my_twitter_handle", uid: '321')
        sign_in :organizer, organizer
      end

      it "raises a not authorized error" do
        expect { patch :update, id: "not_my_twitter_handle" }.
          to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "organizer is authorized" do
      before { sign_in :organizer, organizer }
      let(:cfp_deadline) { DateTime.parse "Oct 1, 2016" }
      let(:begin_date) { DateTime.parse "Apr 1, 2016" }
      let(:end_date) { DateTime.parse "Apr 4, 2016" }
      let(:conference_info) do
        {
          id: twitter_handle,
          name: "Most excellent conf",
          website_url: "http://most-excellent-conf.example.com",
          cfp_deadline: cfp_deadline,
          cfp_url: "http://most-excellent-conf.example.com/cfp",
          begin_date: begin_date,
          end_date: end_date,
          has_travel_funding: true,
          has_lodging_funding: true,
          has_honorariums: true,
          has_diversity_scholarships: true
        }
      end

      def send_patch
        patch :update, id: "myconf", conference: conference_info
      end

      it "redirects to the conference" do
        send_patch
        expect(response).to redirect_to(conference)
      end

      it "approves the conference" do
        expect { send_patch }.
          to change { conference.reload.approved_at }.from(nil)
      end

      describe "conference attributes" do
        subject(:updated_conference) do
          conference.reload
        end

        it "updates the name" do
          expect { send_patch }.
            to change { conference.reload.name }.to("Most excellent conf")
        end

        it "updates the website url" do
          expect { send_patch }.
            to change { conference.reload.website_url }.
            to("http://most-excellent-conf.example.com")
        end

        it "updates the CFP deadline" do
          expect { send_patch }.
            to change { conference.reload.cfp_deadline }.
            to(cfp_deadline)
        end

        it "updates the CFP URL" do
          expect { send_patch }.
            to change { conference.reload.cfp_url }.
            to("http://most-excellent-conf.example.com/cfp")
        end

        it "updates the conference start date" do
          expect { send_patch }.
            to change { conference.reload.begin_date }.
            to(begin_date)
        end

        it "updates the conference end date" do
          expect { send_patch }.
            to change { conference.reload.end_date }.
            to(end_date)
        end

        it "updates the travel funding" do
          expect { send_patch }.
            to change { conference.reload.has_travel_funding }
        end

        it "updates the lodging funding" do
          expect { send_patch }.
            to change { conference.reload.has_lodging_funding }
        end

        it "updates the honorariums" do
          expect { send_patch }.
            to change { conference.reload.has_honorariums }
        end

        it "updates the diversity scholarships" do
          expect { send_patch }.
            to change { conference.reload.has_diversity_scholarships }
        end
      end
    end
  end

  describe "GET #index" do
    let!(:conference) do
      Conference.create(twitter_handle: twitter_handle, approved_at: Time.now, uid: "668")
    end

    let!(:unapproved_conference) do
      Conference.create(twitter_handle: 'grumpyconf', approved_at: nil, uid: "669")
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
