# frozen_string_literal: true

FactoryGirl.define do
  factory :bank do
    sequence(:name) { |n| Faker::Lorem.sentence(n) }
    sequence(:code) { |n| Faker::Number.number(4).to_i - n }
  end
end
