namespace :update do
  desc "Update all conferences"
  task conferences: :environment do
    TwitterUpdater.authenticated.update_conferences
  end

  desc "Update all tweets"
  task tweets: :environment do
    TwitterUpdater.authenticated.update_tweets
  end
end
