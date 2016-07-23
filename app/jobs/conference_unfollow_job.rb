class ConferenceUnfollowJob < ActiveJob::Base
  queue_as :default

  def perform(uid)
    Conference.find_by!(uid: uid).update_attributes!(unfollowed_at: Time.current)
  end
end
