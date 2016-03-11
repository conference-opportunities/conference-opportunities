class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def new_session_path(_scope)
    root_path
  end

  def pundit_user
    current_conference_organizer
  end
end
