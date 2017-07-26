# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to have_field(:description).of_type(String) }
  it { is_expected.to validate_presence_of :description }

  it { is_expected.to have_field(:price).of_type(Float) }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }

  it do
    is_expected.to have_field(:paid).of_type(
      Mongoid::Boolean
    ).with_default_value_of(false)
  end

  it { is_expected.to have_field(:date).of_type(Date) }
  it { is_expected.to validate_presence_of(:date) }

  it { is_expected.to have_field(:note).of_type(String) }

  it { is_expected.to belong_to :account }
  it { is_expected.to respond_to :account }
  it { is_expected.to validate_presence_of :account }

  it { is_expected.to belong_to :category }
  it { is_expected.to respond_to :category }
  it { is_expected.to validate_presence_of :category }

  it { is_expected.to belong_to :subcategory }
  it { is_expected.to respond_to :subcategory }

  it { is_expected.to belong_to :user }
  it { is_expected.to respond_to :user }

  it { is_expected.to belong_to :recurrence }
  it { is_expected.to respond_to :recurrence }
  it { is_expected.to accept_nested_attributes_for :recurrence }
end
