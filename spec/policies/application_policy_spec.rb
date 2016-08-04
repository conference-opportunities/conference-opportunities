require 'rails_helper'

RSpec.describe ApplicationPolicy do
  let(:conference) { FactoryGirl.create(:conference) }
  let(:record) do
    class Application
      def id; 0; end
      def self.where(conditions = {}); OpenStruct.new(exists?: true); end
    end
    Application.new
  end

  subject(:policy) { ApplicationPolicy.new(user, record) }

  context 'when not logged in' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:dashboard) }
    it { is_expected.to forbid_action(:show_in_app) }
    it { is_expected.to forbid_action(:export) }
  end

  context 'when logged in as the admin' do
    let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: '765') }

    before do
      allow(Rails.application.config).to receive(:application_twitter_id).and_return('765')
    end

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to permit_action(:dashboard) }
    it { is_expected.to permit_action(:show_in_app) }
    it { is_expected.to permit_action(:export) }
  end

  context 'when logged in as a normal organizer' do
    let(:user) { FactoryGirl.create(:organizer, conference: conference, uid: '765') }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:dashboard) }
    it { is_expected.to forbid_action(:show_in_app) }
    it { is_expected.to forbid_action(:export) }
  end
end
