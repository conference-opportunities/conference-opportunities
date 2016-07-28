class ConferenceUnfollowJob < ActiveJob::Base
  queue_as :default

  def self.from_event(user)
    perform_later(user.id)
  end

  def perform(uid)
    Conference.find_by!(uid: uid).update_attributes!(unfollowed_at: Time.current)
  end
end
