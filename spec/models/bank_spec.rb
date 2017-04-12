require 'rails_helper'

RSpec.describe Bank, type: :model do
  it {is_expected.to respond_to :name}
  it {is_expected.to validate_presence_of :name}
  it {is_expected.to validate_uniqueness_of :name}

  it {is_expected.to respond_to :code}
  it {is_expected.to validate_presence_of :code}
  it {is_expected.to validate_numericality_of :code}
  it {is_expected.to validate_uniqueness_of :code}
  it {is_expected.to validate_length_of(:code).within(1..4)}
end
