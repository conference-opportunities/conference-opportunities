require 'rails_helper'

RSpec.describe ApprovalsController, type: :controller do
  describe 'GET #show' do
    it 'succeeds' do
      get :show
      expect(response).to be_success
    end
  end
end
