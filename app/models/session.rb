class Session < ApplicationRecord
  belongs_to :browser
  validates_presence_of :name, :created
end
