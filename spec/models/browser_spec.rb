# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Browser model
RSpec.describe Browser, type: :model do
  # Association test
  # ensure Browser model has a m:1 relationship with the Device model
  it do
    should belong_to(:device)
  end
  # Validation tests
  # ensure columns name and nickname are present before saving
  it do
    should validate_presence_of(:name)
  end
  it do
    should validate_presence_of(:nickname)
  end
end
