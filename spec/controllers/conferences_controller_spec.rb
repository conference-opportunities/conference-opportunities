require 'rails_helper'

RSpec.describe ConferencesController, type: :controller do
  describe 'GET #show' do

    subject(:make_request) { get :show, params: { id: conference } }
    let(:conference) { create :conference }

    context 'when requested conference is approved' do
      before { conference.update!(approved_at: 2.hours.ago) }

      it { is_expected.to be_success }

      it 'assigns the conference' do
        make_request
        expect(assigns(:conference).class).to be ConferencePresenter
      end
    end

    context 'when the conference is not approved' do
      it { expect { make_request }.to raise_error(Pundit::NotAuthorizedError) }
    end

    context 'when the requested conference does not exist' do
      before { conference.destroy! }

      it 'raises a not found exception' do
        expect { make_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #index' do
    let!(:conferences) { create_list :conference, 3, :approved }

    subject(:make_request) { get :index }

    it { is_expected.to be_success }

    it 'assigns all the approved conferences' do
      make_request
      expect(assigns(:conferences).map(&:conference)).to match_array conferences
    end
  end
end
