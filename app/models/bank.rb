class Bank
  include Mongoid::Document

  field :name, type: String
  field :code, type: Integer

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :code, numericality: true
  validates :code, length: {in: 1..4}
end
