# [@CallbackWomen](https://twitter.com/callbackwomen): The Website

The Pivotal Tracker backlog for this project can be found at (https://www.pivotaltracker.com/n/projects/1433838).

## Development

Welcome to Rails.  You'll need Postgres set up locally.

```
$ bundle install
$ bundle exec rake db:setup
```

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
