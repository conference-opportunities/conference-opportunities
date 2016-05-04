require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ConferenceOpportunities
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app/presenters')
    config.active_record.raise_in_transactional_callbacks = true
    config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden

    config.i18n.fallbacks = true
    config.i18n.enforce_available_locales = false
  end
end
