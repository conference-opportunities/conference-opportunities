class Conferences::DetailsController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  def edit
    authorize current_conference
    @conference_detail = Conference::Detail.new(
      conference: current_conference,
      location: current_conference.location,
    )
  end

  def update
    authorize current_conference
    @conference_detail = Conference::Detail.new(conference_params.merge(conference: current_conference))
    if @conference_detail.save
      redirect_to(edit_conference_structure_path(@conference_detail.conference))
    else
      flash.now.alert = @conference_detail.errors.full_messages
      render :edit
    end
  end

  private

  def current_conference
    @current_conference ||= Conference.find_by!(twitter_handle: params[:conference_id])
  end

  def conference_params
    params.require(:conference_detail).permit(:location, :starts_at, :ends_at, :attendee_count)
  end
end
