class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def new_session_path(_scope)
    root_path
  end

  def pundit_user
    current_organizer
  end

  def current_locale
    return params[:locale] if params.has_key?(:locale)
    return current_organizer.locale if organizer_signed_in?
    I18n.default_locale
  end

  def set_locale
    if organizer_signed_in?
      current_organizer.assign_attributes(locale: current_locale)
      current_organizer.save if current_organizer.changed?
    end
    I18n.locale = current_locale
  end
end
