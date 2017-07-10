# frozen_string_literal: true

FactoryGirl.define do
  factory :recurrence do
    every 'month'
    on 15
    interval 'monthly'
    repeat Faker::Number.between(1, 60)
  end
end
