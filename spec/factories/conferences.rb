FactoryGirl.define do
  factory :conference do
    twitter_handle { "#{FFaker::Color.name}#{FFaker::Color.name}conf" }
    uid { rand(10_000..10_000_000).to_s }

    trait :unfollowed do
      unfollowed_at { 1.hour.ago }
    end

    trait :approved do
      approved_at { 2.hours.ago }
    end
  end
end
