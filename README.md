# Conference Opportunties
[![Circle CI](https://circleci.com/gh/minifast/conference-opportunities.svg?style=svg)](https://circleci.com/gh/minifast/conference-opportunities) [![Code Climate](https://codeclimate.com/github/minifast/conference-opportunities/badges/gpa.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Test Coverage](https://codeclimate.com/github/minifast/conference-opportunities/badges/coverage.svg)](https://codeclimate.com/github/minifast/conference-opportunities/coverage) [![Issue Count](https://codeclimate.com/github/minifast/conference-opportunities/badges/issue_count.svg)](https://codeclimate.com/github/minifast/conference-opportunities) [![Dependency Status](https://gemnasium.com/minifast/conference-opportunities.svg)](https://gemnasium.com/minifast/conference-opportunities)

Conference Opportunities is a branded (but reusable under the MIT license!) open source application powering the CallbackWomen conference search site.  CallbackWomen curates data about conferences for professional programmers, specifically data around:

1. Gender Diversity, Inclusion, and Access
2. Outstanding talks given by women and by gender nonbinary people

Conference Opportunities serves CallbackWomen's mission of increasing gender diversity at technology conferences.  Find out more about CallbackWomen, as well as resources for conferences and speakers, at (http://www.callbackwomen.com).


#### How does Conference Opportunities work?

**If you're the administrator** Conference Opportunities lists your Twitter followers as Conferences.  If you've tweeted at (or retweeted) a Conference, those Tweets appear in that Conference's profile page.

**If you're followed by the administrator** Conference Opportunities lets you log in with your Twitter account and approve your listing on the front page.  By default, the only information that gets displayed is what you've entered on Twitter.  You can take this one step further and list upcoming Occasions that you'd like to solicit talks from Speakers.

**If you'd like to speak at a conference** Conference Opportunities is the best place to check out all the latest information about upcoming CFPs and D+I information on Conferences.


## Development

Conference Opportunities uses the [Ruby on Rails](https://rubyonrails.org) open source web application framework.  You can make changes on your own computer and contribute them back to this application.  You'll need a few tools to get started.


### Machine Requirements

Make sure your machine is configured for Ruby on Rails development.  You can [search for guides](https://www.google.com/search?q=rails+development+setup+guide) on how to set up Rails on your local machine.

You'll need to install the following software:

* Ruby 2.3.1
* Postgres 9.4+
* Redis 3+
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


## Troubleshooting

* Try adding `export ` in front of each environment variable. Example:
  ```export GOOGLE_MAPS_API_KEY=key```
* Try `cd`-ing out and back into the folder.
* Make sure your `.env` file is located at the root level of the project.
* Make sure the Twitter app has a Callback URL set in the Settings tab. Otherwise you'll see a 401 error from Omniauth.


## Testing

```
$ bundle exec rspec
```

**Note:** The first time you run the spec, phantomjs will install. Do not be alarmed.

**Note:** While running the specs, the browser will open running feature specs. Do not be alarmed.


## Deployment

CallbackWomen is automatically deployed whenever [CircleCI](https://circleci.com/gh/minifast/conference-opportunities) determines that all tests have passed.  If you create a pull request, Heroku will create a sample application to review your proposed changes.


## Contributing

1. Fork it ( https://github.com/minifast/conference-opportunities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


### What should I work on?

The Pivotal Tracker backlog for this project can be found at (https://www.pivotaltracker.com/n/projects/1433838).  The backlog contains a roadmap for the immediate future of development.  Issues and open work items for the community are curated at (https://github.com/minifast/conference-opportunities/issues).
