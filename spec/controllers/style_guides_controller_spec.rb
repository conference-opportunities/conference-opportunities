require 'rails_helper'

RSpec.describe StyleGuidesController, type: :controller do
  describe 'GET #index' do
    def make_request
      get :index
    end

    it 'succeeds' do
      make_request
      expect(response).to be_success
    end

    it 'renders with the style guide layout' do
      make_request
      expect(response).to render_template('layouts/style_guide')
    end

    it 'assigns the style guides' do
      make_request
      expect(assigns(:style_guides)).not_to be_empty
    end
  end
end
