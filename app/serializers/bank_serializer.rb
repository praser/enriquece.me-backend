class BankSerializer < ActiveModel::Serializer
  type :bank
  attributes :id, :name, :code
end
