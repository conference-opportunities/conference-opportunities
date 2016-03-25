class Organizers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    organizer = Organizer.from_omniauth(request.env["omniauth.auth"])
    if organizer.save
      sign_in organizer
      if organizer.admin?
        redirect_to rails_admin.dashboard_path
      else
        redirect_to edit_conference_path(organizer.conference)
      end
    else
      redirect_to root_path, alert: 'You are not a conference'
    end
  end
end
