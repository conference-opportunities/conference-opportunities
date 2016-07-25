require 'rails_helper'

RSpec.describe Organizers::OmniauthCallbacksController, type: :controller do
  let(:uid) { '123545' }
  let(:twitter_handle) { 'conf' }

  let(:valid_twitter_auth) do
    OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: uid,
      info: {nickname: twitter_handle}
    )
  end

  describe '#twitter' do
    before do
      request.env['omniauth.auth'] = valid_twitter_auth
    end

    def make_request
      get :twitter
    end

    context 'when the corresponding conference exists' do
      let!(:conference) do
        Conference.create!(twitter_handle: 'conf', uid: uid)
      end
      before do
        allow(Rails.application.config).to receive(:application_twitter_id).and_return(uid)
      end

      it 'redirects to the admin path' do
        make_request
        expect(response).to redirect_to(/admin/)
      end
    end

    context 'when the organizer is not an admin' do
      context 'when the corresponding conference exists' do
        let!(:conference) do
          Conference.create!(twitter_handle: twitter_handle, uid: uid)
        end

        it 'redirects the conference listing page' do
          make_request
          expect(response).to redirect_to new_conference_listing_path(conference)
        end
      end

      context 'when there is no corresponding conference' do
        it 'redirects to the home page' do
          make_request
          expect(response).to redirect_to root_path
        end

        it 'warns the user that they are not a conference' do
          make_request
          expect(flash[:alert]).to include 'Could not authenticate you'
        end
      end
    end
  end
end
