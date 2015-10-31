namespace :update do
  task conferences: :environment do
    TwitterUpdater.authenticated.update_conferences
  end
end
