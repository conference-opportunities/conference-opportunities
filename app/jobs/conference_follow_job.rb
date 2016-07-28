class ConferenceFollowJob < ActiveJob::Base
  queue_as :default

  def self.from_event(user)
    perform_later(user.id)
  end

  def perform(uid)
    user = TwitterCredentials.create.client.user(uid)
    conference = Conference.find_or_initialize_by(uid: user.id)
    conference.update_from_twitter(user).update_attributes!(unfollowed_at: nil)
  end
end
