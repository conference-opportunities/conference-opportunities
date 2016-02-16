class Conferences::ApprovalsController < ApplicationController
  before_action :authenticate_conference_organizer!, only: [:create]

  def create
    conference = Conference.find_by_twitter_handle!(params[:conference_id])
    authorize conference, :edit?
    conference.update_attributes!(conference_params.merge(approved_at: Time.now))
    redirect_to conference
  end

  private

  def conference_params
    params.require(:conference).permit(:name, :website_url)
  end
end
