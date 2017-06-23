# frozen_string_literal: true

# Account serializer
class AccountSerializer < ActiveModel::Serializer
  type :account
  attributes :id, :name, :description, :initial_balance
  belongs_to :bank
  belongs_to :account_type
end
