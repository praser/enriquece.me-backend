class CategorySerializer < ActiveModel::Serializer
	type :category
	attributes :name
end