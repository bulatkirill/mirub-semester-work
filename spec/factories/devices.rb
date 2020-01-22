# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    name do
      Faker::Lorem.word
    end
    nickname do
      Faker::Lorem.word
    end
  end
end
