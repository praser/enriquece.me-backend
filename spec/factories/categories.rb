# frozen_string_literal: true

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| Faker::Pokemon.name + n.to_s }
    user
  end
end
