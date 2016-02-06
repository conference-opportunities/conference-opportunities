class ConferencePresenter < Struct.new(:instance)
  extend Forwardable
  def_delegators :instance, :logo_url, :name, :website_url, :location,
    :description, :tweets

  def twitter_name
    "@#{instance.twitter_handle}"
  end

  def twitter_url
    "https://twitter.com/#{instance.twitter_handle}"
  end
end
