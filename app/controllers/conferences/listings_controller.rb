class Conferences::ListingsController < ApplicationController
  before_action :authenticate_organizer!, only: [:new, :create]

  class ConferenceListing
    include ActiveModel::Model

    attr_accessor :name, :website_url, :conference
    validates :name, presence: true

    def save
      return false unless valid?
      persist
      true
    end

    def persist
      conference.update_attributes!(
        name: name,
        website_url: website_url,
        approved_at: Time.now
      )
    end
  end

  def new
    @conference = Conference.find_by!(twitter_handle: params[:conference_id])
    authorize @conference, :update?
  end

  def create
    @conference = Conference.find_by!(twitter_handle: params[:conference_id])
    authorize @conference, :update?
    conference_listing = ConferenceListing.new(conference_params.merge(conference: @conference))
    if conference_listing.save
      redirect_to(edit_conference_detail_path(@conference))
    else
      flash.alert = conference_listing.errors.full_messages
      render :new
    end
  end

  private

  def conference_params
    params.require(:conference).permit(:name, :website_url)
  end
end
