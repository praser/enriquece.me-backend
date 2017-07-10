# frozen_string_literal: true

# Financial Transaction Serializer
class FinancialTransactionSerializer < ActiveModel::Serializer
  type :financial_transaction
  attributes :description, :price, :note

  belongs_to :account
  belongs_to :category
  belongs_to :subcategory
  belongs_to :recurrence
end
