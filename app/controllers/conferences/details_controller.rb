class Conferences::DetailsController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  def edit
    @conference_detail = Conference::Detail.new(
      conference: current_conference,
      location: current_conference.location,
      starts_at: current_conference.starts_at,
      ends_at: current_conference.ends_at
    )
    authorize @conference_detail
  end

  def update
    @conference_detail = Conference::Detail.new(conference_params.merge(conference: current_conference))
    authorize @conference_detail
    if @conference_detail.save
      redirect_to(@conference_detail.conference)
    else
      flash.alert = @conference_detail.errors.full_messages
      render :edit
    end
  end

  private

  def current_conference
    @current_conference ||= Conference.find_by!(twitter_handle: params[:conference_id])
  end

  def conference_params
    params.require(:conference_detail).permit(:location, :starts_at, :ends_at)
  end
end
