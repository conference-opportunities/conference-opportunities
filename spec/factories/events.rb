FactoryGirl.define do
  factory :event do
    conference
    address { "#{rand(1300..1399)} Mockingbird Lane, Atlantic City, New Jersey" }
    latitude { rand(-89..89) }
    longitude { rand(-179..179) }
    starts_at { rand(1..3).weeks.from_now }
    ends_at { starts_at + rand(1..3).days }
    call_for_proposals_ends_at { starts_at - rand(1..3).days }
  end
end
