class Conferences::StructuresController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  def edit
    authorize current_conference
    @conference_structure = Conference::Structure.new(conference: current_conference)
  end

  def update
    authorize current_conference
    @conference_structure = Conference::Structure.new(conference_params.to_h.merge(conference: current_conference))
    if @conference_structure.save
      redirect_to conference_path(@conference_structure.conference)
    else
      flash.now.alert = @conference_structure.errors.full_messages
      render :edit
    end
  end

  private

  def current_conference
    @current_conference ||= Conference.find_by!(twitter_handle: params[:conference_id])
  end

  def conference_params
    params.require(:conference_structure).permit(
      :track_count,
      :plenary_count,
      :tutorial_count,
      :workshop_count,
      :keynote_count,
      :talk_count,
      :other_count,
      :cfp_count,
      :prior_submissions_count,
      :panel_count,
    )
  end
end
