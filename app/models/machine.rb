class Machine < ApplicationRecord
  has_many :browsers, dependent: :destroy
  validates_presence_of :name, :nickname
end
