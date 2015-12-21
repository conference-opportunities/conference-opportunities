namespace :update do
  desc "Update all conferences"
  task conferences: :environment do
    TwitterUpdater.authenticated.update_conferences
  end

  desc "Update all tweets"
  task tweets: :environment do
    last_tweet = Tweet.all.last || NullTweet.new
    TwitterUpdater.authenticated.update_tweets(last_tweet.twitter_id.to_i + 1)
  end
end
