FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence(:email) {|n| Faker::Internet.email(n)}
    password '123456'
  end
end
