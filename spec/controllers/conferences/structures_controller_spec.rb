require 'rails_helper'

RSpec.describe Conferences::StructuresController, type: :controller do
  let(:conference) { FactoryGirl.create(:conference) }
  let(:organizer) { FactoryGirl.create(:organizer, conference: conference) }

  describe 'GET #edit' do
    def make_request(id = conference.twitter_handle)
      get :edit, params: {conference_id: id}
    end

    context 'when logged in as the organizer for the conference' do
      before { sign_in(organizer, scope: :organizer) }

      context 'when the conference exists' do
        before { make_request }

        it 'succeeds' do
          expect(response).to be_success
        end

        it 'assigns the conference' do
          expect(assigns(:conference_structure).conference).to eq(conference)
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

  describe 'PATCH #update' do
    def make_request(params = {}, id = conference.twitter_handle)
      patch :update, params: {conference_id: id, conference_structure: params}
    end

    context 'when logged in as the organizer for the conference' do
      before { sign_in(organizer, scope: :organizer) }

      context 'when the conference exists' do
        context 'when the number of tracks has not been selected' do
          before { make_request(track_count: 'zzz') }

          it 'flashes a failure message' do
            expect(flash.alert).to include('Number of tracks is not a number')
          end

          it 'assigns the conference' do
            expect(assigns(:conference_structure).conference).to eq(conference)
          end

          it 'render the edit view' do
            expect(response).to render_template(:edit)
          end
        end

        context 'when the conference information is valid' do
          let(:valid_data) do
            {
              track_count: 2,
              plenary_count: 3,
              tutorial_count: 10,
              workshop_count: 5,
              keynote_count: 0,
              talk_count: 0,
              other_count: 0,
              cfp_count: 15,
              prior_submissions_count: 30
            }
          end

          it 'updates the number of tracks' do
            expect { make_request(valid_data) }
              .to change { conference.reload.track_count }
              .to(2)
          end

          it 'updates the conference plenary count' do
            expect { make_request(valid_data) }
              .to change { conference.reload.plenary_count }
              .to(3)
          end

          it 'redirects to the conference page' do
            make_request(valid_data)
            expect(response).to redirect_to(conference_path(conference))
          end
        end
      end

      context 'when the conference does not exist' do
        it 'raises an error' do
          expect {
            make_request({location: ''}, 'nope')
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'when logged in as some other organizer' do
      let(:other_conference) { FactoryGirl.create(:conference) }
      let(:other_organizer) { FactoryGirl.create(:organizer, conference: other_conference) }

      before { sign_in(other_organizer, scope: :organizer) }

      it 'raises an error' do
        expect {
          make_request(location: '')
        }.to raise_error(Pundit::NotAuthorizedError)
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

