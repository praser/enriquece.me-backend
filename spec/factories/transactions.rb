# frozen_string_literal: true

FactoryGirl.define do
  factory :transaction do
    description Faker::Lorem.word
    price Faker::Number.decimal(2)
    date Faker::Date.between(
      30.days.ago,
      Time.zone.today.at_end_of_month.next_month
    )
    paid { [true, false].sample }
    note Faker::Lorem.sentence
    association :account, factory: :account
    association :category, factory: :category
    association :subcategory, factory: :subcategory
    association :user, factory: :user

    trait :invalid do
      description nil
      price nil
      note nil
      account nil
      category nil
      subcategory nil
      recurrence nil
    end
  end
end
