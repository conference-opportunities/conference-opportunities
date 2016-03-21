class ConferencesController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  def index
    @conferences = policy_scope(Conference)
  end

  def show
    authorize current_conference
    @conference = ConferencePresenter.new(current_conference)
  end

  def edit
    @conference = current_conference
    authorize @conference
  end

  def update
    @conference = current_conference
    authorize @conference, :edit?
    @conference.update_attributes!(conference_params.merge(approved_at: Time.now))
    redirect_to @conference
  end

  private

  def current_conference
    Conference.find_by_twitter_handle!(params[:id])
  end

  def conference_params
    params.require(:conference).
    permit(:cfp_deadline, :cfp_url, :begin_date, :end_date, :has_travel_funding,
     :has_lodging_funding, :has_honorariums, :has_diversity_scholarships, :name,
     :website_url)
  end

end
