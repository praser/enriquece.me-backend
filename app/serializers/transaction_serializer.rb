# frozen_string_literal: true

# Transaction Serializer
class TransactionSerializer < ActiveModel::Serializer
  type :transaction
  attributes :description, :price, :date, :paid, :note

  belongs_to :account
  belongs_to :category
  belongs_to :subcategory
  belongs_to :recurrence
end
