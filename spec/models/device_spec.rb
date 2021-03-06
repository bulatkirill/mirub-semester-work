# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Device model
RSpec.describe(Device, type: :model) do
  # Association test
  # ensure Device model has a 1:m relationship with the Browser model
  it do
    should have_many(:browsers).dependent(:destroy)
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
