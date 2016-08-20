class ApplicationController < ActionController::Base
  include Pundit

  after_action :verify_authorized, except: :index, unless: :skipped_controller?
  after_action :verify_policy_scoped, only: :index, unless: :skipped_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def new_session_path(_scope)
    root_path
  end

  def pundit_user
    current_organizer
  end

  def skipped_controller?
    devise_controller? || self.is_a?(RailsAdmin::ApplicationController)
  end
end
