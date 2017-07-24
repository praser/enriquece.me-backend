# frozen_string_literal: true

# Subcategory model
class Subcategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :category

  validates :name, presence: true
  validates :name, uniqueness: { scope: :category_id, case_sensitive: false }
  validates :category_id, presence: true
end
