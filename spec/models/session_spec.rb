require 'rails_helper'

RSpec.describe Session, type: :model do
  # Association test
  # ensure Session model has a m:1 relationship with the Browser model
  it do
    should belong_to(:browser)
  end
  # Association test
  # ensure Session model has a 1:m relationship with the Tabs model
  it do
    should have_many(:tabs).dependent(:destroy)
  end
  # Validation tests
  # ensure column name is present before saving
  it do
    should validate_presence_of(:name)
  end

end
