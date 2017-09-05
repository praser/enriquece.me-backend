# frozen_string_literal: true

FactoryGirl.define do
  factory :account do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    initial_balance { Faker::Number.decimal(2) }
    bank
    account_type
    user
  end
end
