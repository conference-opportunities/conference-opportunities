FactoryGirl.define do
  factory :tweet do
    conference
    twitter_id { rand(10_000..10_000_000).to_s }
  end
end
