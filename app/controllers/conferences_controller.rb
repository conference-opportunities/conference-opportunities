class ConferencesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :return_not_found

  def show
    conference = Conference.find_by_twitter_handle!(params[:id])
    @conference = ConferencePresenter.new(conference)
  end

  def index
    @conferences = Conference.all
  end

  private

  def return_not_found
    render file: '/public/404.html', status: 404
  end
end
