require 'rails_helper'

RSpec.describe Tab, type: :model do
  # Association test
  # ensure Tab model has a m:1 relationship with the Session model
  it do
    should belong_to(:session)
  end
  # Validation tests
  # ensure column url is present before saving
  it do
    should validate_presence_of(:url)
  end
  # Validation tests
  # ensure column domain is present before saving
  it do
    should validate_presence_of(:domain)
  end

end
