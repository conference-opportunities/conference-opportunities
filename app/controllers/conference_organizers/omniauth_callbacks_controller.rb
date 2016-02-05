class ConferenceOrganizers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    organizer = ConferenceOrganizer.from_omniauth(request.env["omniauth.auth"])
    if organizer.save
      sign_in organizer
      redirect_to conference_path(organizer.conference)
    else
      redirect_to root_path
    end
  end
end
