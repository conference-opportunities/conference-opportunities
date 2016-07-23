class ConferenceBatchJob < ActiveJob::Base
  queue_as :default

  def perform
    old_conferences = Set.new(Conference.pluck(:uid).map(&:to_i))
    new_conferences = Set.new(TwitterCredentials.create.client.friend_ids.to_a)
    (old_conferences & new_conferences).each_slice(100) { |ids| ConferenceUpdateJob.perform_later(ids) }
    (old_conferences - new_conferences).each { |id| ConferenceUnfollowJob.perform_later(id) }
    (new_conferences - old_conferences).each { |id| ConferenceFollowJob.perform_later(id) }
  end
end
