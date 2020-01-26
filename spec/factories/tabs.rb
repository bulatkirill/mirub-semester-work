# frozen_string_literal: true

FactoryBot.define do
  factory :tab do
    url do
      Faker::Internet.url
    end
    domain do
      Faker::Internet.url
    end
  end
end
