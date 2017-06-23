# frozen_string_literal: true

# BankSerializer
class BankSerializer < ActiveModel::Serializer
  type :bank
  attributes :id, :name, :code
end
