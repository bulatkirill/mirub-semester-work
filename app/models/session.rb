class Session < ApplicationRecord
  belongs_to :browser
  has_many :tabs
  validates_presence_of :name
end
