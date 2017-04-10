require 'rails_helper'

RSpec.describe User, type: :model do
  it {is_expected.to respond_to :name}
  it {is_expected.to validate_presence_of :name}
  
  it {is_expected.to respond_to :email}
  it {is_expected.to validate_presence_of :email}
  it {is_expected.to validate_uniqueness_of :email}
  it {is_expected.to validate_format_of(:email).to_allow(Faker::Internet.email).not_to_allow("'invalid email'")}
  
  it {is_expected.to respond_to :password}
  it {is_expected.to validate_presence_of :password}
end