namespace :update do
  desc "Update all conferences"
  task conferences: :environment do
    TwitterUpdater.authenticated.update_conferences
  end
end
