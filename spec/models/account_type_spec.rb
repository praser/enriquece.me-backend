require 'rails_helper'

RSpec.describe AccountType, type: :model do
  it {is_expected.to validate_presence_of :name}
  it {is_expected.to validate_uniqueness_of :name}
end