FactoryGirl.define do
  factory :event do
    conference
    address { "#{rand(1300..1399)} Mockingbird Lane, Atlantic City, New Jersey" }
    latitude { rand(-89..89) }
    longitude { rand(-179..179) }
    starts_at { rand(1..3).weeks.from_now }
    ends_at { starts_at + rand(1..3).days }
    speaker_notifications_at { starts_at - rand(1..3).days }
    call_for_proposals_ends_at { speaker_notifications_at - rand(1..3).days }

    trait :complete do
      hashtag { "#{FFaker::Color.name}conf#{rand(10..20)}" }
      code_of_conduct_url { "https://example.com/conduct/#{rand(10..20)}" }
      call_for_proposals_url { "https://example.com/cfp/#{rand(10..20)}" }

      has_childcare { [true, false].sample }
      has_diversity_scholarships { [true, false].sample }
      has_honorariums { [true, false].sample }
      has_lodging_funding { [true, false].sample }
      has_travel_funding { [true, false].sample }

      attendees_count { rand(1..10) }
      prior_submissions_count { rand(1..10) }
      submission_opportunities_count { rand(1..10) }

      keynotes_count { rand(1..10) }
      other_talks_count { rand(1..10) }
      panels_count { rand(1..10) }
      plenaries_count { rand(1..10) }
      talks_count { rand(1..10) }
      tracks_count { rand(1..10) }
      tutorials_count { rand(1..10) }
      workshops_count { rand(1..10) }
    end
  end
end
