# frozen_string_literal: true

# Category model
class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :user
  has_many :subcategories

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :user_id, presence: true
end
