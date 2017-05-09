class CategorySerializer < ActiveModel::Serializer
	type :category
	attributes :name
end

class SubcategorySerializer < ActiveModel::Serializer
	type :subcategory
	attributes :name
	belongs_to :category
end