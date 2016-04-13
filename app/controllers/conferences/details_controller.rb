class Conferences::DetailsController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  class ConferenceDetail
    include ActiveModel::Model

    attr_accessor :location, :starts_at, :ends_at, :conference
    validates :location, :starts_at, :ends_at, presence: true

    def save
      return false unless valid?
      persist
      true
    end

    def persist
      conference.update_attributes!(
        location: location,
        starts_at: starts_at,
        ends_at: ends_at,
      )
    end
  end


  def edit
    @conference = Conference.find_by!(twitter_handle: params[:conference_id])
    authorize @conference, :update?
  end

  def update
    @conference = Conference.find_by!(twitter_handle: params[:conference_id])
    authorize @conference, :update?
    conference_detail = ConferenceDetail.new(conference_params.merge(conference: @conference))
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
