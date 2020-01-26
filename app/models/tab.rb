# frozen_string_literal: true

# entity representing a tab
class Tab < ApplicationRecord
  belongs_to :session
  validates_presence_of :url, :domain
end
