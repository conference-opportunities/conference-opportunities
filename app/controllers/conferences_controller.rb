class ConferencesController < ApplicationController
  def index
    @conferences = policy_scope(Conference).map { |c| ConferencePresenter.new(c) }
  end

  def show
    authorize current_conference
    @conference = ConferencePresenter.new(current_conference)
  end

  private

  def current_conference
    Conference.find_by_twitter_handle!(params[:id])
  end
end
