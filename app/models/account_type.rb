# frozen_string_literal: true

# AccountType model
class AccountType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :accounts

  validates :name, presence: true, uniqueness: true
end
