require 'rails_helper'

RSpec.describe Account, type: :model do
	it {is_expected.to respond_to :name}
  it {is_expected.to validate_presence_of :name}
  it {is_expected.to validate_length_of(:name).with_maximum(100)}

  it {is_expected.to respond_to :description}
  it {is_expected.to validate_length_of(:description).with_maximum(500)}

  it {is_expected.to respond_to :initial_balance}
  it {is_expected.to validate_presence_of :initial_balance}
  it {is_expected.to validate_numericality_of :initial_balance}

  it {is_expected.to belong_to(:bank)}
  it {is_expected.to validate_presence_of :bank_id}

  it {is_expected.to belong_to(:account_type)}
  it {is_expected.to validate_presence_of :account_type_id}

  it {is_expected.to belong_to(:user)}
  it {is_expected.to validate_presence_of :user_id}
end
