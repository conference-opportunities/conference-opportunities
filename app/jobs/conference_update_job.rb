class ConferenceUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(uids)
    users = TwitterCredentials.create.client.users(uids)
    users.map { |user| Conference.find_by!(uid: user.id).update_from_twitter(user) }.each(&:save!)
  end
end
