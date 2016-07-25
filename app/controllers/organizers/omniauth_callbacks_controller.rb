class Organizers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    organizer = Organizer.from_omniauth(request.env['omniauth.auth'])
    if organizer.save
      sign_in organizer
      if organizer.admin?
        redirect_to rails_admin.dashboard_path
      else
        redirect_to new_conference_listing_path(organizer.conference)
      end
    else
      redirect_to root_path, alert: t('devise.omniauth_callbacks.failure',
        kind: 'Twitter',
        reason: t('devise.omniauth_callbacks.not_followed')
      )
    end
  end
end
