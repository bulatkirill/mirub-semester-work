# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    name do
      Faker::Lorem.word
    end
  end
end
