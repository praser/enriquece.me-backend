FactoryGirl.define do
  factory :bank do
    name Faker::Bank.name
    code Faker::Number.number(4)
  end
end
