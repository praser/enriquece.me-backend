FactoryGirl.define do
  factory :subcategory do
    sequence(:name) {|n| Faker::Pokemon.name + n.to_s}
    category
  end
end
