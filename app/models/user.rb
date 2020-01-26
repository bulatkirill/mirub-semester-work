# frozen_string_literal: true

# entity representing a user
class User < ApplicationRecord
  has_secure_password
end
