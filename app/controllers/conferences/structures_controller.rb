class Conferences::StructuresController < ApplicationController
  before_action :authenticate_organizer!, only: [:edit, :update]

  def edit
    @conference_structure = Conference::Structure.new(
      conference: current_conference,
      track_count: current_conference.track_count,
      plenary_count: current_conference.plenary_count,
      tutorial_count: current_conference.tutorial_count,
      workshop_count: current_conference.workshop_count,
      keynote_count: current_conference.keynote_count,
      talk_count: current_conference.talk_count,
      other_count: current_conference.other_count,
      cfp_count: current_conference.cfp_count,
      prior_submissions_count: current_conference.prior_submissions_count,
      panel_count: current_conference.panel_count,
    )
    authorize @conference_structure
  end

  def update
    @conference_structure = Conference::Structure.new(conference_params.to_h.merge(conference: current_conference))
    authorize @conference_structure
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
