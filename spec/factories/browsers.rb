# frozen_string_literal: true

FactoryBot.define do
  factory :browser do
    name do
      Faker::Lorem.word
    end
    nickname do
      Faker::Lorem.word
    end
  end
end
