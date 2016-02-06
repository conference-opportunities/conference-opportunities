class ConferencesController < ApplicationController
  before_action :authenticate_conference_organizer!, only: [:edit]

  def index
    @conferences = Conference.all
  end

  def show
    @conference = ConferencePresenter.new(current_conference)
  end

  def edit
    @conference = current_conference
    authorize @conference
  end

  private

  def current_conference
    Conference.find_by_twitter_handle!(params[:id])
  end
end
