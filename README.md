# [@CallbackWomen](https://twitter.com/callbackwomen): The Website
[![Circle CI](https://circleci.com/gh/minifast/conference-opportunities.svg?style=svg)](https://circleci.com/gh/minifast/conference-opportunities) [![Code Climate](https://codeclimate.com/github/minifast/conference-opportunities/badges/gpa.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Test Coverage](https://codeclimate.com/github/minifast/conference-opportunities/badges/coverage.svg)](https://codeclimate.com/github/minifast/conference-opportunities/coverage) [![Issue Count](https://codeclimate.com/github/minifast/conference-opportunities/badges/issue_count.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Dependency Status](https://gemnasium.com/minifast/conference-opportunities.svg)](https://gemnasium.com/minifast/conference-opportunities)

Conference Opportunities is a branded (but reusable under the MIT license!) open source application powering the CallbackWomen conference search site.

The Pivotal Tracker backlog for this project can be found at (https://www.pivotaltracker.com/n/projects/1433838).

The site can be found at (http://www.callbackwomen.com).


## Development

Conference Opportunities uses the [Ruby on Rails](https://rubyonrails.org) open source web application framework.  You can make changes on your own computer and contribute them back to this application.  You'll need a few tools to get started.


### Machine Requirements

Make sure your machine is configured for Ruby on Rails development.  You can [search for guides](https://www.google.com/search?q=rails+development+setup+guide) on how to set up Rails on your local machine.

You'll need to install the following software:

* Ruby 2.3.1
* Postgres 9.4+
* Heroku Toolbelt


### First-Time Application Setup

1. Copy `config/database.yml.example` to `config/database.yml`:
    ```
    $ cp config/database.yml.example config/database.yml
    ```

2. Copy `.env.example` to `.env`:
    ```
    $ cp .env.example .env
    ```

3. Install dependencies with `bundle install`:
    ```
    $ bundle install
    ```

4. Set up the database with `rake db:setup`:
    ```
    $ rake db:setup
    ```

5. Run the app with `heroku local`:
    ```
    $ heroku local
    ```


### First-Time Twitter API Setup

Conference Opportunities uses Twitter to authenticate Organizers and site admins.  In order to log in with a Twitter account, your application needs secret credentials.  In order to get those secret Twitter credentials, you'll probably need to make a new development account.

> For example, developers at [Ministry of Velocity](https://ministryofvelocity.com) made `@fakemovaccount` for this purpose.  Sharing is great, but please make your own totally fake Twitter handle.

Once you've got a development account, you'll need to make a Twitter app at (https://apps.twitter.com).  Click the "Create New App" button, and on the next screen enter the following information:

```
Name: [YOUR NAME HERE]'s Conferences
Description: A collection of my favorite conferences
Website: https://callbackwomen.com
Callback URL: [BLANK]
```

Next, click the "Keys and Access Tokens" tab and generate a new access token:

![twitter_tokens_instructions](/app/assets/images/readme_screenshots/twitter_tokens_instructions.png)

Add or change the following lines in your `.env` file (minus the square brackets):

```
TWITTER_CONSUMER_KEY=[Consumer Key (API Key)]
TWITTER_CONSUMER_SECRET=[Consumer Secret (API Secret)]
TWITTER_ACCESS_TOKEN=[Access Token]
TWITTER_ACCESS_TOKEN_SECRET=[Access Token Secret]
```

> If these keys and tokens change at any point, you'll need to copy them into your `.env` file again.


### First-Time Google Maps API Setup

Conference Opportunities uses the Google Maps API to figure out the latitude and longitude of conferences.  In order to get address information, your application needs secrets from Google's API Console at (https://console.developers.google.com/apis/credentials).

If you don't have one already, you'll need to make a new project:

![create_project](/app/assets/images/readme_screenshots/create_project.png)

> For example, developers at [Ministry of Velocity](https://ministryofvelocity.com) made a project called `callback-women-development`

Next, go to the "Credentials" section in the sidebar, select the "Credentials" tab (really!), create a new API key, and select "Browser key":

![google_api_instruction](/app/assets/images/readme_screenshots/google_api_instruction.png)

You can name it whatever you'd like.

Add or change the following lines in your `.env` file (minus the square brackets):

```
GOOGLE_MAPS_API_KEY=[Key]
```

**TROUBLESHOOTING STEPS**

* Try adding `export ` in front of each environment variable. Example:
  ```export GOOGLE_MAPS_API_KEY=key```
* Try `cd`-ing out and back into the folder.
* Make sure your `.env` file is located at the root level of the project.


## Testing

```
$ bundle exec rspec
```

**Note:** The first time you run the spec, phantomjs will install. Do not be alarmed.

**Note:** While running the specs, the browser will open running feature specs. Do not be alarmed.


## Deployment

If you have permission to deploy, please use Heroku. If you are a contributor and do not have explicit permission to deploy, don't worry! Your contribution will be reviewed and deployed via Heroku when ready. Unfortunately, there is no set timeframe for merging PRs.

Later, make sure the Twitter app has a Callback URL set in the Settings tab.
Otherwise you'll see a 401 error from Omniauth.


## Contributing

1. Fork it ( https://github.com/minifast/conference-opportunities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
