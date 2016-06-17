# [@CallbackWomen](https://twitter.com/callbackwomen): The Website
[![Circle CI](https://circleci.com/gh/minifast/conference-opportunities.svg?style=svg)](https://circleci.com/gh/minifast/conference-opportunities) [![Code Climate](https://codeclimate.com/github/minifast/conference-opportunities/badges/gpa.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Test Coverage](https://codeclimate.com/github/minifast/conference-opportunities/badges/coverage.svg)](https://codeclimate.com/github/minifast/conference-opportunities/coverage) [![Issue Count](https://codeclimate.com/github/minifast/conference-opportunities/badges/issue_count.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Dependency Status](https://gemnasium.com/minifast/conference-opportunities.svg)](https://gemnasium.com/minifast/conference-opportunities)


The Pivotal Tracker backlog for this project can be found at (https://www.pivotaltracker.com/n/projects/1433838).

The site can be found at (http://www.callbackwomen.com)

## Development

Welcome to Rails.  You'll need Postgres set up locally.

```
$ bundle install
```
Next, you'll need to create a ```.env``` file and generate the 5 environment variables to start developing the app:

* `GOOGLE_MAPS_API_KEY`=YOUR_KEY_HERE
* `TWITTER_CONSUMER_KEY`=YOUR_KEY_HERE
* `TWITTER_CONSUMER_SECRET`=YOUR_KEY_HERE
* `TWITTER_ACCESS_TOKEN`=YOUR_KEY_HERE
* `TWITTER_ACCESS_TOKEN_SECRET`=YOUR_KEY_HERE

###Env Variables
* `GOOGLE_MAPS_API_KEY`
  * Get this from [https://console.developers.google.com/apis/credentials](https:/console.developers.google.com/apis/credentials)
  * When you see the screen pictured below, enter in a name to create the project. The name can be anything of your choosing.
  * Choose "Browser key"
  * Copy key into the ```.env``` file. (Example: ```GOOGLE_MAPS_API_KAY=YOUR_KEY_HERE```)

* `TWITTER_CONSUMER_KEY` (and all twitter keys)
  * Get this from [https://apps.twitter.com/](https://apps.twitter.com/)
  * For "website", enter ```http://www.callbackwomen.com```
  * For the rest of the twitter-related keys, go to the "keys and access tokens" tab (screenshot below)

##Database Setup

Create your ```database.yml``` file by doing
```
$ cp config/database.yml.example config/database.yml
```

```
$ bundle exec rake db:setup
```

## Testing

For integration testing, we use [@fakemovaccount](https://twitter.com/fakemovaccount).

```
$ bundle exec rspec
```

**Note:** The first time you run the spec, phantomjs will install. Do not be alarmed.
**Note:** While running the specs, the browser will open running feature specs. Do not be alarmed.

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
