require 'rails_helper'

RSpec.describe LetsEncryptVerificationsController, type: :controller do
  describe 'GET #show' do
    let(:check) { LetsEncryptVerificationsController::LetsEncryptCheck.new('encryption-rulz', 'moar-encrypt-plz') }

    before { allow(LetsEncryptVerificationsController::LetsEncryptCheck).to receive(:create).and_return(check) }

    def make_request(inbound_challenge)
      get :show, params: {id: inbound_challenge}
    end

    context 'when the incoming challenge is valid' do
      it 'is successful' do
        expect(response).to be_success
      end

      it 'renders the response' do
        make_request('encryption-rulz')
        expect(response.body).to eq('moar-encrypt-plz')
      end
    end

    context 'when the incoming challenge is invalid' do
      it 'is forbidden' do
        make_request('encryption-sux')
        expect(response).to be_forbidden
      end
    end
  end
end
