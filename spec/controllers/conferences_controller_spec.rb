require 'rails_helper'

RSpec.describe ConferencesController, type: :controller do
  describe 'GET #show' do
    let(:conference) { create :conference }

    subject(:make_request) { get :show, params: { id: conference } }

    context 'when requested conference is approved' do
      before { conference.update!(approved_at: 2.hours.ago) }

      it { is_expected.to be_success }

      it 'assigns the conference' do
        make_request
        expect(assigns(:conference).class).to be ConferencePresenter
      end
    end

    context 'when the conference is not approved' do
      it { expect { make_request }
        .to raise_error(Pundit::NotAuthorizedError) }
    end

    context 'when the requested conference does not exist' do
      before { conference.destroy! }

      it 'raises a not found exception' do
        expect { make_request }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #index' do
    let!(:non_approved_conference) { create :conference }
    let!(:approved_conferences) { create_list :conference, 3, :approved }

    subject(:make_request) { get :index }

    it { is_expected.to be_success }

    context 'when listing conferences' do
      subject { assigns(:conferences).map(&:conference) }

        before { get :index }
        it { is_expected.not_to include non_approved_conference }
        it { is_expected.to match_array approved_conferences }
    end
  end
end
