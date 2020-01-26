# frozen_string_literal: true

# entity representing a browser
class Browser < ApplicationRecord
  belongs_to :device
  has_many :sessions, dependent: :destroy
  validates_presence_of :name, :nickname
end
