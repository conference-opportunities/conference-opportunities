require 'rails_helper'

RSpec.describe ConferencesController, type: :controller do
  describe 'GET #show' do
    def make_request(id)
      get :show, params: {id: id}
    end

    context 'when requested conference is approved' do
      let!(:conference) { FactoryGirl.create(:conference, :approved, twitter_handle: 'fooconf') }

      it 'is successful' do
        make_request('fooconf')
        expect(response).to be_success
      end

      it 'assigns the conference' do
        make_request('fooconf')
        expect(assigns(:conference)).to be
      end
    end

    context 'when the conference is not approved' do
      let!(:conference) { FactoryGirl.create(:conference, twitter_handle: 'fooconf') }

      it 'redirects to the home page' do
        expect { make_request('fooconf') }.
          to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when the requested conference does not exist' do
      it 'raises a not found exception' do
        expect { make_request('notaconf') }.
          to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #index' do
    let!(:conference) { FactoryGirl.create(:conference, :approved) }

    def make_request
      get :index
    end

    it 'returns http success' do
      make_request
      expect(response).to be_success
    end

    it 'assigns all the approved conferences' do
      make_request
      expect(assigns(:conferences).map(&:conference)).to eq([conference])
    end
  end
end
