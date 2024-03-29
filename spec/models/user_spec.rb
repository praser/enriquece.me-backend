# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to respond_to :name }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to respond_to :email }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_format_of(:email).not_to_allow('invalid email') }
  it do
    is_expected.to validate_format_of(:email).to_allow(Faker::Internet.email)
  end

  it { is_expected.to respond_to :password }
  it { is_expected.to validate_presence_of(:password).on(:create) }
  it { is_expected.to validate_length_of(:password).within(6..20) }

  it { is_expected.to have_many(:accounts) }
  it { is_expected.to have_many(:categories) }
end
