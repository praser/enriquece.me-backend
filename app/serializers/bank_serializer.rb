# frozen_string_literal: true

# Bank serializer
class BankSerializer < ActiveModel::Serializer
  type :bank
  attributes :id, :name, :code
end
