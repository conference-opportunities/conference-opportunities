FactoryGirl.define do
  factory :organizer do
    uid { rand(10_000...10_000_000).to_s }
    provider 'twitter'

    trait :admin do
      uid Rails.application.config.application_twitter_id
      conference nil
    end
  end
end
