# frozen_string_literal: true

# base class of all entities in the application to be persisted
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
