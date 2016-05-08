require "rails_helper"

RSpec.describe ApplicationController do
  let(:scope) { double(:scope) }

  describe "#new_session_path" do
    it "returns root path" do
      expect(controller.new_session_path(scope)).to eq root_path
    end
  end

  describe "#pundit_user" do
    let(:conference) { Conference.create!(twitter_handle: "punditconf", uid: '123') }
    let(:organizer) { Organizer.create!(uid: '123', provider: 'twitter', conference: conference) }

    before { sign_in organizer }

    it "returns the current organizer" do
      expect(controller.pundit_user).to eq(organizer)
    end
  end

  describe '#set_locale' do
    context 'when the organizer is logged in' do
      let(:conference) { Conference.create!(twitter_handle: "punditconf", uid: '123') }
      let(:organizer) { Organizer.create!(uid: '123', provider: 'twitter', conference: conference, locale: "zb") }

      before { sign_in organizer }

      it 'sets the organizer locale' do
        params = {locale: 'bt'}
        allow(controller).to receive(:params).and_return(params)
        expect {
          controller.set_locale
        }.to change { organizer.reload.locale }.from('zb').to('bt')
      end
    end

    it 'sets the locale to the current locale' do
      expect(I18n).to receive(:default_locale).and_return('di_SO')
      expect {
        controller.set_locale
      }.to change { I18n.locale }.to(:di_SO)
    end
  end

  describe '#current_locale' do
    context 'when no locale or organizer are present' do
      it 'returns the default locale' do
        expect(controller.current_locale).to eq('en')
      end
    end

    context 'when the locale parameter is set' do
      it 'returns the parameter' do
        params = {locale: 'zx'}
        allow(controller).to receive(:params).and_return(params)
        expect(controller.current_locale).to eq('zx')
      end
    end

    context 'when the organizer is logged in' do
      let(:conference) { Conference.create!(twitter_handle: "punditconf", uid: '123') }
      let(:organizer) { Organizer.create!(uid: '123', provider: 'twitter', conference: conference, locale: "zb") }

      before { sign_in organizer }

      it 'returns the organizer locale' do
        expect(controller.current_locale).to eq('zb')
      end
    end
  end
end
