# frozen_string_literal: true

# Category serializer
class CategorySerializer < ActiveModel::Serializer
  type :category
  attributes :name
  has_many :subcategories
end
