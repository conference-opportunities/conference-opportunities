class ConferencePresenter < Struct.new(:conference)
  extend Forwardable
  def_delegators :conference, :logo_url, :name, :website_url, :location,
    :description, :tweets

  def twitter_name
    "@#{conference.twitter_handle}"
  end

  def twitter_url
    "https://twitter.com/#{conference.twitter_handle}"
  end
end
