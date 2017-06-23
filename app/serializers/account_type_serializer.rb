# frozen_string_literal: true

# AccountType serializer
class AccountTypeSerializer < ActiveModel::Serializer
  type :account_type
  attributes :name
end
