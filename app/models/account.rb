# frozen_string_literal: true

# Account model
class Account
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :initial_balance, type: Float

  belongs_to :bank
  belongs_to :account_type
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :initial_balance, presence: true, numericality: true
  validates :bank_id, presence: true
  validates :account_type_id, presence: true
  validates :user_id, presence: true
end
