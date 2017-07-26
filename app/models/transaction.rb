# frozen_string_literal: true

# Financial Transaction Model
class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String
  field :price, type: Float
  field :date, type: Date
  field :paid, type: Boolean, default: false
  field :note, type: String

  belongs_to :account
  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :recurrence, optional: true
  belongs_to :user

  validates :description, presence: true

  validates :price, presence: true
  validates :price, numericality: true

  validates :date, presence: true

  accepts_nested_attributes_for :recurrence
end
