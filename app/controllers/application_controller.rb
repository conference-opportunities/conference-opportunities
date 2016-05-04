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

  def set_locale
    I18n.locale = params[:locale] if params.has_key?(:locale)
  end
end
