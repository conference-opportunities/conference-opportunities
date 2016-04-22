class Conferences::DetailsController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  def edit
    @conference = Conference.find_by!(twitter_handle: params[:conference_id])
    authorize @conference, :update?
  end

  def update
    @conference = Conference.find_by!(twitter_handle: params[:conference_id])
    authorize @conference, :update?
    conference_detail = Conferences::Detail.new(conference_params.merge(conference: @conference))
    if conference_detail.save
      redirect_to(@conference)
    else
      flash.alert = conference_detail.errors.full_messages
      render :edit
    end
  end

  private

  def conference_params
    params.require(:conference).permit(:location, :starts_at, :ends_at)
  end
end
