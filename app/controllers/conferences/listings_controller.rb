class Conferences::ListingsController < ApplicationController
  before_action :authenticate_organizer!, only: [:new, :create]

  def new
    authorize current_conference, :edit?
    @conference_listing = Conference::Listing.new(
      conference: current_conference,
      name: current_conference.name,
      website_url: current_conference.website_url,
      logo_url: current_conference.logo_url,
    )
  end

  def create
    authorize current_conference, :update?
    @conference_listing = Conference::Listing.new(conference_params.merge(conference: current_conference))
    if @conference_listing.save
      redirect_to(edit_conference_detail_path(@conference_listing.conference))
    else
      flash.now.alert = @conference_listing.errors.full_messages
      render :new
    end
  end

  private

  def current_conference
    @current_conference ||= Conference.find_by!(twitter_handle: params[:conference_id])
  end

  def conference_params
    params.require(:conference_listing).permit(:name, :website_url, :logo_url)
  end
end
