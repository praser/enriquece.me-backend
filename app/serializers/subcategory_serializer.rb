# frozen_string_literal: true

# Subcategory serializer
class SubcategorySerializer < ActiveModel::Serializer
  type :subcategory
  attributes :name
  belongs_to :category
end
