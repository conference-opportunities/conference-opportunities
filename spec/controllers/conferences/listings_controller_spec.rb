require 'rails_helper'

RSpec.describe Conferences::ListingsController, type: :controller do
  let(:conference) { FactoryGirl.create(:conference) }
  let(:organizer) { FactoryGirl.create(:organizer, conference: conference) }

  describe 'GET #new' do
    def make_request(id = conference.twitter_handle)
      get :new, params: {conference_id: id}
    end

    context 'when logged in as the organizer for the conference' do
      before { sign_in(organizer, scope: :organizer) }

      context 'when the conference exists' do
        before { make_request }

        it 'succeeds' do
          expect(response).to be_success
        end

        it 'assigns the conference' do
          expect(assigns(:conference_listing).conference).to eq(conference)
        end
      end

      context 'when the conference does not exist' do
        it 'raises an error' do
          expect { make_request('nope') }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'when logged in as some other organizer' do
      let(:other_conference) { FactoryGirl.create(:conference) }
      let(:other_organizer) { FactoryGirl.create(:organizer, conference: other_conference) }

      before { sign_in(other_organizer, scope: :organizer) }

      it 'raises an error' do
        expect { make_request }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when not logged in' do
      it 'boots the browser back to the root path' do
        make_request
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    def make_request(params = {}, id = conference.twitter_handle)
      post :create, params: {conference_id: id, conference_listing: params}
    end

    context 'when logged in as the organizer for the conference' do
      before { sign_in(organizer, scope: :organizer) }

      context 'when the conference exists' do
        context 'when the conference name is empty' do
          before { make_request(name: '') }

          it 'flashes a failure message' do
            expect(flash.alert).to include("Conference name can't be blank")
          end

          it 'assigns the conference' do
            expect(assigns(:conference_listing).conference).to eq(conference)
          end

          it 'render the new view' do
            expect(response).to render_template(:new)
          end
        end

        context 'when the conference information is valid' do
          it 'approves the conference' do
            expect { make_request(name: 'nowconf') }
              .to change { conference.reload.approved_at }
              .from(nil)
          end

          it 'updates the conference name' do
            expect { make_request(name: 'confconf') }
              .to change { conference.reload.name }
              .to('confconf')
          end

          it 'updates the conference website url' do
            expect { make_request(name: 'confconf', website_url: 'http://example.com/confconf') }
              .to change { conference.reload.website_url }
              .to('http://example.com/confconf')
          end

          it 'redirects to the conference details page' do
            make_request(name: 'indirectconf')
            expect(response).to redirect_to(edit_conference_detail_path(conference))
          end
        end
      end

      context 'when the conference does not exist' do
        it 'raises an error' do
          expect { make_request({name: ''}, 'nope') }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'when logged in as some other organizer' do
      let(:other_conference) { FactoryGirl.create(:conference) }
      let(:other_organizer) { FactoryGirl.create(:organizer, conference: other_conference) }

      before { sign_in(other_organizer, scope: :organizer) }

      it 'raises an error' do
        expect { make_request(name: '') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when not logged in' do
      it 'boots the browser back to the root path' do
        make_request
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
