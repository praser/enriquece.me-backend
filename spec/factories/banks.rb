# frozen_string_literal: true

FactoryGirl.define do
  factory :bank do
    sequence(:name) { |n| Faker::Lorem.sentence(n) }
    sequence(:code) { |n| n }
  end
end
