require 'rails_helper'

RSpec.describe OrganizerConference do
  it { is_expected.to belong_to(:organizer) }
  it { is_expected.to belong_to(:conference) }
end
