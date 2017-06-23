# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  it { is_expected.to respond_to :name }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:category_id) }

  it { is_expected.to belong_to :category }
  it { is_expected.to validate_presence_of :category_id }
end
