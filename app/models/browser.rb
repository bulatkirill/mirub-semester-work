class Browser < ApplicationRecord
  belongs_to :machine
  has_many :sessions, dependent: :destroy
  validates_presence_of :name, :nickname
end
