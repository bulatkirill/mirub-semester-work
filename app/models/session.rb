# frozen_string_literal: true

# entity representing a session
class Session < ApplicationRecord
  belongs_to :browser
  has_many :tabs, dependent: :destroy
  validates_presence_of :name
end
