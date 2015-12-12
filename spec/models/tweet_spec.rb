require 'rails_helper'

RSpec.describe Tweet do
  it { is_expected.to belong_to(:conference) }
end
