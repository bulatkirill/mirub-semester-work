class Browser < ApplicationRecord
  belongs_to :machine
  validates_presence_of :name, :nickname
end
