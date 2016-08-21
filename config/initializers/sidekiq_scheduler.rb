require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load(ERB.new(Rails.root.join('config/scheduler.yml').read).result)[Rails.env]
    Sidekiq::Scheduler.reload_schedule!
  end
end
