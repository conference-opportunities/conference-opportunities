require 'rails_helper'

RSpec.describe OrganizerConference, type: :model do
  it { is_expected.to belong_to(:organizer) }
  it { is_expected.to belong_to(:conference) }
end
