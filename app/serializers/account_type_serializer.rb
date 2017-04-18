class AccountTypeSerializer < ActiveModel::Serializer
	type :account_type
	attributes :name
end