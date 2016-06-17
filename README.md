# [@CallbackWomen](https://twitter.com/callbackwomen): The Website
[![Circle CI](https://circleci.com/gh/minifast/conference-opportunities.svg?style=svg)](https://circleci.com/gh/minifast/conference-opportunities) [![Code Climate](https://codeclimate.com/github/minifast/conference-opportunities/badges/gpa.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Test Coverage](https://codeclimate.com/github/minifast/conference-opportunities/badges/coverage.svg)](https://codeclimate.com/github/minifast/conference-opportunities/coverage) [![Issue Count](https://codeclimate.com/github/minifast/conference-opportunities/badges/issue_count.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Dependency Status](https://gemnasium.com/minifast/conference-opportunities.svg)](https://gemnasium.com/minifast/conference-opportunities)


The Pivotal Tracker backlog for this project can be found at (https://www.pivotaltracker.com/n/projects/1433838).

## Development

Welcome to Rails.  You'll need Postgres set up locally.

```
$ bundle install
```
```
$ bundle exec rake db:setup
```

You'll need 5 environment variables to start developing the app:

* `GOOGLE_MAPS_API_KEY`: get this from [https://console.developers.google.com/apis/credentials](https://console.developers.google.com/apis/credentials)
* `TWITTER_CONSUMER_KEY`: get this from [https://apps.twitter.com/](https://apps.twitter.com/)
* `TWITTER_CONSUMER_SECRET`: ditto
* `TWITTER_ACCESS_TOKEN`: ditto
* `TWITTER_ACCESS_TOKEN_SECRET`: ditto

## Testing

For integration testing, we use [@fakemovaccount](https://twitter.com/fakemovaccount).

```
$ bundle exec rspec
```

## Deployment

Use Heroku.

Later, make sure the Twitter app has a Callback URL set in the Settings tab.
Otherwise you'll see a 401 error from Omniauth.

## Contributing

1. Fork it ( https://github.com/minifast/conference-opportunities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
