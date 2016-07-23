require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ConferenceOpportunities
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app/presenters')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden

    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :es]
    config.i18n.enforce_available_locales = false
    config.i18n.fallbacks = {:es => [:en], en: [:es]}

    config.active_job.queue_adapter = :sidekiq
  end
end
