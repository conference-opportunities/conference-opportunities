require 'rails_helper'

RSpec.describe Conferences::DetailsController, type: :controller do
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
          expect(assigns(:conference_detail).conference).to eq(conference)
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
      patch :update, params: {conference_id: id, conference_detail: params}
    end

    context 'when logged in as the organizer for the conference' do
      before { sign_in(organizer, scope: :organizer) }

      context 'when the conference exists' do
        context 'when the conference location is empty' do
          before { make_request(location: '') }

          it 'flashes a failure message' do
            expect(flash.alert).to include("Location can't be blank")
          end

          it 'assigns the conference' do
            expect(assigns(:conference_detail).conference).to eq(conference)
          end

          it 'render the edit view' do
            expect(response).to render_template(:edit)
          end
        end

        context 'when the conference information is valid' do
          it 'updates the conference location' do
            make_request(location: 'Barrow, AK', starts_at: Date.today, ends_at: Date.today)
            expect(conference.reload.event.address).to eq('Barrow, AK')
          end

          it 'updates the conference start date' do
            make_request(location: 'Barrow, AK', starts_at: Date.today, ends_at: Date.today)
            expect(conference.reload.event.starts_at).to eq(Date.today)
          end

          it 'updates the conference end date' do
            make_request(location: 'Barrow, AK', starts_at: Date.today, ends_at: Date.today + 1.day)
            expect(conference.reload.event.ends_at).to eq(Date.today + 1.day)
          end

          it 'redirects to the conference structure page' do
            make_request(location: 'Barrow, AK', starts_at: Date.today, ends_at: Date.today + 1.day)
            expect(response).to redirect_to(edit_conference_structure_path(conference))
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
