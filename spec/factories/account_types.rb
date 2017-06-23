# frozen_string_literal: true

FactoryGirl.define do
  factory :account_type do
    sequence(:name) { |n| Faker::Lorem.sentence(n) }
  end
end
